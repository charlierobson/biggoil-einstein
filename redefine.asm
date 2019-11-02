;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module REDEF

	.align  64
_keychar:
	.db		$84,0,$C0,$C7,$83,$82,$81,$80
	.asc	"IOP"
	.db		$85
	.asc	"_"
	.db		$86,$87
	.asc	"0"
	.asc	"KL;:"
	.db		$88,$89
	.asc	"9"
	.db		$C5
	.asc	",./8"
	.db		$8a
	.asc	"="
	.db		$8b,$C4
	.asc	"7654321"
	.db		$C3
	.asc	"UYTREWQ"
	.db		$C2
	.asc	"JHGFDSA"
	.db		$C1
	.asc	"MNBVCXZ"
	.db		$C6

_kcs:
	.word	_k0,_k1,_k2,_k3,_k4,_k5
	.word	_k6,_k7,_k8,_k9,_k10,_k11


_k0:
	.asc	"ESC",$ff
_k1:
	.asc	"SPACE",$ff
_k2:
	.asc	"ENTER",$ff
_k3:
	.asc	"AL",$ff
_k4:
	.asc	"BREAK",$ff
_k5:
	.asc	"<-",$ff
_k6:
	.asc	"LF",$ff
_k7:
	.asc	"1/2",$ff
_k8:
	.asc	"->",$ff
_k9:
	.asc	"HT",$ff
_k10:
	.asc	"DEL",$ff
_k11:
	.asc	"%",$ff


_bit2bytetbl:
	.byte	128,64,32,16,8,4,2,1


_pkf:
	.asc	"press key for:",$ff

_upk:
	.dw		up-2			; -3 because UP points at last byte of 4 byte structure
	.dw		$0a04
	.asc	"up: ",$ff

_dnk:
	.dw		down-2
	.dw		$0a06
	.asc	"down: ",$ff

_lfk:
    .dw     left-2
    .dw     $0a08
	.asc	"left: ",$ff

_rtk:
    .dw     right-2
    .dw     $0a0a
	.asc	"right: ",$ff

_frk:
    .dw     fire-2
    .dw     $0a0c
	.asc	"retract: ",$ff



redefinekeys:
    call    cls

	ld		hl,_pkf
	ld		de,$0802
	call	textOut

-:	call	waitVSync
	call	_getcolbit			; wait for key release
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

	; fall

_redeffit:
	ld		e,(hl)
	inc		hl
	ld		d,(hl)
	inc		hl
	ld		(keyaddress),de		; the input data we're altering

	ld		e,(hl)				; screen position into de
	inc		hl
	ld		d,(hl)
	inc		hl

	call	textOut				; text at hl -> screen

_redefloop:
	call	waitVSync
	call	_getcolbitDebounced
	jr		z,_redefloop

	; when we return from getting the column bit l = column index, a = bit mask

	ex		de,hl
	ld		hl,(keyaddress)
	ld		(hl),e                  ; stash row
	inc		hl
	ld		(hl),a                  ; stash col mask

    call    _bit2byte               ; col mask -> bit number (64 -> 6,  1 -> 0 etc)
    jr      nz,_redefloop	        ; if not exactly 1 bit set then the bit pattern is invalid, try again

    ld      a,c                     ; store the bit number for the key
    ld      (keycol),a

	ld		a,e                     ; column number
    ld      (keyrow),a

    call    _keytoscreen

_redefnokey:
	call	waitVSync
	call	_getcolbit
	jr		nz,_redefnokey
	ret



_getcolbit:
	ld		b,$08			; b is loop count, c is row selector bit
	ld		hl,keystates

-:	ld		a,(hl)
	and		a
	ret		nz

	inc		hl
	djnz	{-}

    and     a
	ret


_getcolbitDebounced:
	call	_getcolbit
	ret		z

	ld		b,4						; timer

-:	call	waitVSync
	cp		(hl)
	jr		nz,_dbnope				; nope, released too soon or glitchy

	djnz	{-}

	and		a						; we hit required time so ok
	ret

_dbnope:
	xor		a
	ret


_bit2byte:
	push	hl
	ld		hl,_bit2bytetbl
	ld		bc,8
	cpir
	pop		hl
    ret                             ; P set if key bit wasn't found (moer than one bit set)




_keytobuf:
	ld		hl,memoutputter
	ld		(outputter+1),hl
	jr		_keyoutman


_keytoscreen:
	ld		hl,vdpoutputter
	ld		(outputter+1),hl

	; fall into

_keyoutman:
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
	bit		7,a
	jr		z,_itsachar

	and		127
	bit		6,a
	jr		z,_itsastring

	; it's an F key
	and		63
	push	af
	ld		a,43	; "F"
	call	outputter
	pop		af
	add		a,$1c

_itsachar:
	; fall into outputter

outputter:
	jp		0

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

-:	call	outputter
+:	ld		a,(hl)
    inc     hl
	cp		$ff
	jr		nz,{-}
	ret


vdpoutputter:
    out     (VDP_DATA),a
	ret

memoutputter:
    ld		(de),a
	inc		de
	ret
