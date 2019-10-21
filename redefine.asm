;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module REDEF


;   7       6       5       4       3       2       1       0    bit
;-------+-------+-------+-------+-------+-------+-------+-------.
; ENTER | SPACE |  ---  |  ---  |R.SHIFT|L.SHIFT| FUNC  | CTRL  | 30
;-------+-------+-------+-------+-------+-------+-------+-------+
;   8   |   7   |   6   |   5   |   4   |   3   |   2   |   1   | 31
;-------+-------+-------+-------+-------+-------+-------+-------+
;   I   |   U   |   Y   |   T   |   R   |   E   |   W   |   Q   | 32
;-------+-------+-------+-------+-------+-------+-------+-------+
;   K   |   J   |   H   |   G   |   F   |   D   |   S   |   A   | 33
;-------+-------+-------+-------+-------+-------+-------+-------+
;   ,   |   M   |   N   |   B   |   V   |   C   |   X   |   Z   | 34
;-------+-------+-------+-------+-------+-------+-------+-------+
;   \   |   _   |   /   |   .   |   ^   |   -   |   0   |   9   | 35
;-------+-------+-------+-------+-------+-------+-------+-------+
;   ]   |   :   |   ;   |   L   |   [   |   @   |   P   |   O   | 36
;-------+-------+-------+-------+-------+-------+-------+-------+
; R.JOY | R.JOY | R.JOY | R.JOY | L.JOY | L.JOY | L.JOY | L.JOY | 37
;   |   |  <--  |   ^   |  -->  |   |   |  <--  |   ^   |  -->  |
;   v   |       |   |   |       |   v   |       |   |   |       |
;-------+-------+-------+-------+-------+-------+-------+-------'

	.align  64
_keychar:
	.db	    0,1,2,3,0,0,4,5
	.asc	"12345678"
	.asc	"QWERTYUI"
	.asc	"ASDFGHJK"
	.asc	"ZXCVBNM,"
	.asc	"90-^./_\\"
	.asc	"OP@[L;:]"

_kcs:
	.word	_k0,_k1,_k2,_k3,_k4,_k5
_kcsEnd:

_k0:
	.asc	"CTRL",$ff
_k1:
	.asc	"FUNC",$ff
_k2:
	.asc	"LSHIFT",$ff
_k3:
	.asc	"RSHIFT",$ff
_k4:
	.asc	"SPACE",$ff
_k5:
	.asc	"ENTER",$ff


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
	.asc	"fire:  ",$ff



redefinekeys:
    call    cls

	ld		hl,_pkf
	ld		de,$0802
	call	textOut

	ld		hl,smfx3
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

    ld      hl,keyport
    ld      (hl),c

    call    _bit2byte                ; if the bit pattern is invalid then try again
    jr      nz,_redefloop

    ld      a,c                     ; store the bit number for the key
    ld      (keybit),a

	ld		hl,smfx4
	call	AYFX.PLAY

    call    _showkey

_redefnokey:
	call	_getcolbit
	jr		nz,_redefnokey
	ret



_getcolbit:
	ld		bc,$0730				; b is loop count, c is io address

-:	in      a,(c)                   ; byte will have a 1 bit if a key is pressed
	ret		nz
	inc		c
	djnz	{-}

    and     a
	ret


_getcolbitDebounced:
	ld		bc,$0730				; b is loop count, c is io address

-:	in      a,(c)                   ; byte will have a 1 bit if a key is pressed
	jr		nz,_dbit

	inc		c
	djnz	{-}
  	and     a
	ret

_dbit:
	ld		b,a						; stash the bit we're looking for
	ld		e,10					; start a timer

-:	call	waitVSync
	in		a,(c)
	cp		b
	jr		nz,_dbnope				; nope, released too soon or glitchy

	dec		e
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



_showkey:
	ld		hl,_keychar
	ld		a,(keyport)
    sub     $30
	add		a,a
	add		a,a
	add		a,a
	add		a,l
    ld      l,a

    ld      a,(keybit)
	add		a,l
	ld		l,a

	ld		a,(hl)                      ; is it a char or a string?
	cp		8
	jr		c,{+}

    ; it's a char
    out     (VDP_DATA),a
	ret

    ; it's a string
+:  ld		hl,_kcs
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
