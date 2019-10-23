;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module REDEF

	.align  64
_keychar:
	.db	    7,6,8+0,8+7,3,2,1,0 ; should really be > 128
	.asc	"IOP?_?|0"
	.asc	"KL;:??9",8+5
	.asc	",./8?=?",8+4
	.asc	"7654321",8+3
	.asc	"UYTREWQ",8+2
	.asc	"JHGFDSA",8+1
	.asc	"MNBVCXZ",8+6

_kcs:
	.word	_k0,_k1,_k2,_k3,0,0,0,_k7
_kcsEnd:

_k0:
	.asc	"ESC",$ff
_k1:
	.asc	"SPACE",$ff
_k2:
	.asc	"ENTER",$ff
_k3:
	.asc	"AL",$ff
_k7:
	.asc	"BRK",$ff


_bit2bytetbl:
	.byte	128,64,32,16,8,4,2,1


_pkf:
	.asc	"press key for:",$ff

_upk:
    .dw     up-3                ; -3 because UP points at last byte of 4 byte structure
    .dw     $0a04
	.asc	"up:    ",$ff

_dnk:
    .dw     down-3
    .dw     $0a06
	.asc	"down:  ",$ff

_lfk:
    .dw     left-3
    .dw     $0a08
	.asc	"left:  ",$ff

_rtk:
    .dw     right-3
    .dw     $0a0a
	.asc	"right: ",$ff

_frk:
    .dw     fire-3
    .dw     $0a0c
	.asc	"retract: ",$ff



redefinekeys:
    call    cls

	ld		hl,_pkf
	ld		de,$0802
	call	textOut

	ld		a,3
	call	AYFX.PLAY

-:	call	_getcolbit			; wait for key release
	jr		nz,{-}

	ld		hl,_upk
	call	_redeffit

	ld		hl,_dnk
	call	_redeffit

	ld		hl,_lfk
	call	_redeffit

	ld		hl,_rtk
	call	_redeffit
	
	ld		hl,_frk

_redeffit:
	ld		e,(hl)
	inc		hl
	ld		d,(hl)
	inc		hl
	ld		(keyaddress),de		; the input data we're altering

	ld		e,(hl)
	inc		hl
	ld		d,(hl)
	inc		hl
	call	textOut

_redefloop:
	call	_getcolbitDebounced
	jr		z,_redefloop

	ld		hl,(keyaddress)
	ld		(hl),c                  ; stash IO port address
	inc		hl
	ld		(hl),a                  ; stash bit mask

	push	af
	ld		a,c
	call	_bit2byte
	ld		a,c
    ld      (keyrow),a
	pop		af

    call    _bit2byte                ; if the bit pattern is invalid then try again
    jr      nz,_redefloop

    ld      a,c                     ; store the bit number for the key
    ld      (keycol),a

	ld		a,4
	call	AYFX.PLAY

    call    _showkey

_redefnokey:
	call	_getcolbit
	jr		nz,_redefnokey
	ret



_getcolbit:
	ld		bc,$0801				; b is loop count, c is row selector bit

-:	call	readKeyRow				; byte will have a 1 bit if a key is pressed
	ret		nz
	sla		c
	djnz	{-}

    and     a
	ret


readKeyRow:
    LD		A,0EH
	OUT		(PSG_SEL),A
	ld		a,c						; get key row selector
	CPL								; make it active low
	OUT		(PSG_WR),A
	LD		A,0FH					; read key row
	OUT		(PSG_SEL),A
	IN		A,(PSG_RD)
	CPL								; active low->hi
	and		a
	ret


_getcolbitDebounced:
	ld		bc,$0801				; b is loop count, c is row

-:	call	readKeyRow				; A will be nonzero if a key is pressed
	jr		nz,_dbit

	sla		c						; next row
	djnz	{-}
  	and     a
	ret

_dbit:
	ld		b,a						; stash the bit we're looking for
	ld		l,10					; start a timer

-:	call	waitVSync
	call	readKeyRow
	cp		b
	jr		nz,_dbnope				; nope, released too soon or glitchy

	dec		l
	jr		nz,{-}

	and		a						; we hit required time so ok
	ret

_dbnope:
	xor		a
	ret


testit:
    ld      a,128
    call    _bit2byte
    ld      a,1
    call    _bit2byte
    ld      a,3

_bit2byte:
	ld		hl,_bit2bytetbl
	ld		bc,8
	cpir
    ret                             ; P set if key bit wasn't found (2 keys at once?)




_keytobuf:
	ld		a,(keyrow)
	call	_bit2byte
	ld		a,c
	add		a,a
	add		a,a
	add		a,a
	ld		hl,_keychar
	add		a,l
    ld      l,a

	push	hl
    ld      a,(keycol)
	call	_bit2byte
	pop		hl
	ld		a,c
	add		a,l
	ld		l,a

	ld		a,(hl)                      ; is it a char or a string?
	cp		8
	jr		c,_itsastringk

	cp		16
	jr		nc,_itsachark

	; it's an F key
	push	af
	ld		a,43	; "F"
    ld		(de),a
	inc		de
	pop		af
	add		a,$14

_itsachark:
    ld		(de),a
	inc		de
	ret

    ; it's a string
_itsastringk:
  	ld		hl,_kcs
	add		a,a
	add		a,l
	ld		l,a
	ld		a,(hl)
	inc		hl
	ld		h,(hl)
	ld		l,a
    jr      {+}

-:	ld		(de),a
	inc		de
+:	ld		a,(hl)
    inc     hl
	cp		$ff
	jr		nz,{-}
	ret

; TODO - refactor these 2 fns

_showkey:
	ld		hl,_keychar
	ld		a,(keyrow)
	add		a,a
	add		a,a
	add		a,a
	add		a,l
    ld      l,a

    ld      a,(keycol)
	add		a,l
	ld		l,a

	ld		a,(hl)                      ; is it a char or a string?
	cp		8
	jr		c,_itsastring

	cp		16
	jr		nc,_itsachar

	; it's an F key
	push	af
	ld		a,43	; "F"
    out     (VDP_DATA),a
	pop		af
	add		a,$14

_itsachar:
    out     (VDP_DATA),a
	ret

    ; it's a string
_itsastring:
  	ld		hl,_kcs
	add		a,a
	add		a,l
	ld		l,a
	ld		a,(hl)
	inc		hl
	ld		h,(hl)
	ld		l,a
    jr      {+}

-:	out     (VDP_DATA),a
+:	ld		a,(hl)
    inc     hl
	cp		$ff
	jr		nz,{-}
	ret
