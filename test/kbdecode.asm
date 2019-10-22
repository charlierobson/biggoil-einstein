
    .org $100

PSG	=	00H		;PSG	00-07 	AY-3-8910
PSG_SEL = 02H	;LATCH ADDRESS
PSG_RD	= 02H	;READ FROM PSG
PSG_WR	= 03H	;WRITE TO PSG

VDP_DATA    .equ $08    ; read/write
VDP_REG     .equ $09    ; write
VDP_STAT    .equ $09    ; read


    ld      a,12    ; cls
	.db     $cf,$9E

-:  



    ld      e,$80 ; e = row select bit
    call    row
    srl     e
    call    row
    srl     e
    call    row
    srl     e
    call    row
    srl     e
    call    row
    srl     e
    call    row
    srl     e
    call    row
    srl     e
    call    row

    .db     $cf,$cf
    .db     11,11,11,11,11,11,11,11+$80

    jr      {-}

row:
    LD	A,0EH
	OUT	(PSG_SEL),A
	LD	A,E
	CPL
	OUT	(PSG_WR),A

    LD	A,0FH
	OUT	(PSG_SEL),A
	IN	A,(PSG_RD)
	CPL

    ld      b,8
-:
    push    bc
    rla
    push    af
    ld      a,'0'
    adc     a,0
    .db     $cf,$9E
    pop     af
    pop     bc
    djnz    {-}
    .db     $cf,$a6

    ret
