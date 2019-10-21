
;   7       6       5       4       3       2       1       0    bit/registr
;-------+-------+-------+-------+-------+-------+-------+-------.
;   0   |   0   |   0   |   0   |   0   |   0   |  M3   | EXTVI | R0
;-------+-------+-------+-------+-------+-------+-------+-------+
; VRAM  | BLANK | INTEN |  M1   |  M2   |   0   | SIZE  |  MAG  | R1
;-------+-------+-------+-------+-------+-------+-------+-------+
;   0   |   0   |   0   |   0   |        screen address         | R2
;-------+-------+-------+-------+-------+-------+-------+-------+
;                     color table address                       | R3
;-------+-------+-------+-------+-------+-------+-------+-------+
;   0   |   0   |   0   |   0   |   0   |   char. base address  | R4
;-------+-------+-------+-------+-------+-------+-------+-------+
;   0   |                 Sprite table address                  | R5
;-------+-------+-------+-------+-------+-------+-------+-------+
;   0   |   0   |   0   |   0   |   0   | addr sprite templates | R6
;-------+-------+-------+-------+-------+-------+-------+-------+
;       foreground colour       |   background color or frame   | R7
;-------+-------+-------+-------+-------+-------+-------+-------'


VDP_DATA    .equ $08    ; read/write

VDP_REG     .equ $09    ; write
VDP_STAT    .equ $09    ; read

; vram addresses
SPRPAT      .equ    $0000
PATTBL      .equ    $0800
SPRATTR     .equ    $1000
NAMETBL     .equ    $1400
COLTBL      .equ    $2000

COL_TRANS    .equ $00
COL_BLACK    .equ $01
COL_DGREEN   .equ $0c
COL_MGREEN   .equ $02
COL_LGREEN   .equ $03
COL_DBLUE    .equ $04
COL_LBLUE    .equ $05
COL_DRED     .equ $06
COL_MRED     .equ $08
COL_LRED     .equ $09
COL_CYAN     .equ $07
COL_MAGENTA  .equ $0D
COL_DYELLOW  .equ $0A
COL_LYELLOW  .equ $0B
COL_GREY     .equ $0E
COL_WHITE    .equ $0F

initVDP:  ;  set graphic 1 mode, bg col, vram layout.

    call    displayOff

    ; clear VRAM

    ld      hl,0
    call    setVDPAddress
    ld      e,$40
    ld      b,0
    xor     a
-:  out     (VDP_DATA),a
    djnz    {-}
    dec     e
    jr      nz,{-}

    ; set up the colour table

    ld      hl,COLTBL
    call    setVDPAddress

    ld      a,(COL_BLACK<<4)+COL_WHITE
    ld      b,$20
-:  out     (VDP_DATA),a
    djnz    {-}

    ; set up the pattern table

    ld      hl,PATTBL
    call    setVDPAddress

    ld      e,$00
    call    writeFont
    ld      e,$ff
    call    writeFont

    ; init display mode

    ld      hl,graphic1data             ; pairs of bytes representing a vdp register value and register number with bit 7 set
    ld      de,$7010                    ; copy to ram to modify PAL/NTSC bit (reg 0, bit 0)
    push    de
    ld      bc,16
    ldir
    ld      a,($0f)                     ; PAL ROM contains F3 at this address, NTSC ROM contains F6
    and     1
    ld      ($7010),a                   ; PAL/!NTSC

    pop     hl                          ; data to OUT
    ld      bc,$1011                    ; 16 bytes to port $11
    otir
    ret


displayOff:
    ld      a,$80
    out     (VDP_REG),a
    ld      a,$81
    out     (VDP_REG),a
    ret

displayOn:
    ld      a,$e0
    out     (VDP_REG),a
    ld      a,$81
    out     (VDP_REG),a
    ret


writeFont:
    ld      hl,zx81font
    ld      bc,128*8
-:  ld      a,(hl)
    xor     e
    out     (VDP_DATA),a
    inc     hl
    dec     bc
    ld      a,b
    or      c
    jr      nz,{-}
    ret


graphic1data:
    .db     $01,$80,$e0,$81,$05,$82,$80,$83,$01,$84,$20,$85,$00,$86,(COL_BLACK<<4)+COL_WHITE,$87


; set vdp write address
;  HL     .equ address
;
setVDPAddress:
    ld      a,l
    out     (VDP_REG),a
    ld      a,h
    and     $3F
    or      $40
    out     (VDP_REG),a
    ret



; set vdp write address
;  HL     .equ address
;
writeVDP:
    ld      a,c
    out     (VDP_REG),a
    ld      a,b
    or      $80
    out     (VDP_REG),a
    ret


waitframes:
waitFrames:
    call    waitVSync
    djnz    waitFrames

waitVSync:
    ld      hl,frames
    ld      a,(hl)
-:  cp      (hl)
    jr      z,{-}
    ret


cls:
    di
    call    displayOff

    ld      hl,NAMETBL
    call    setVDPAddress

    xor     a
    ld      bc,3

-:  out     (VDP_DATA),a
    djnz    {-}
    dec     c
    jr      nz,{-}

    call    displayOn
    ei
    ret


_setVDPAddr:
    push    hl
    ld      h,0                     ; hl = NAMETBL + (32 * e) + d
    ld      l,e
    ld      e,d
    ld      d,h
    add     hl,hl
    add     hl,hl
    add     hl,hl
    add     hl,hl
    add     hl,hl
    add     hl,de
    ld      de,NAMETBL
    add     hl,de
    call    setVDPAddress
    pop     hl
    ret



textOut:
    call    _setVDPAddr

-:  ld      a,(hl)
    cp      $ff
    ret     z
    out     (VDP_DATA),a
    inc     hl
    jr      {-}



textOutN:
    call    _setVDPAddr

-:  ld      a,(hl)
    out     (VDP_DATA),a
    inc     hl
    djnz    {-}
    ret



invertScreen:
	ld		hl,dfile
    ld      bc,33*24

-:  ld		a,(hl)
	xor		$80
    ld      (hl),a
    inc     hl
    dec     bc
    ld      a,b
    or      c
    jr      nz,{-}

    ret



framesync:
    call    waitVSync

    ld      a,COL_DRED
    call    setborder

    ld      hl,NAMETBL
    call    setVDPAddress
    ld      hl,dfile+1
    ld      b,24

-:  ld      e,b
    ld      bc,$2000+VDP_DATA
    otir
    inc     hl
    ld      b,e
    djnz    {-}

    ld      a,COL_BLACK

    ; fall in to ..

setborder:
    ret

	out		(VDP_REG),a
	ld		a,$87
	out		(VDP_REG),a

    ret
