;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module HLPSCN

kctobuf:


renderKey:
	push	de

	ld		c,(hl)
	inc		hl
	ld		b,(hl)
	inc 	hl
	ld		a,(bc)	; get pointer to key row/col val
	ld		(keyrow),a
	inc		bc
	ld		a,(bc)
	ld		(keycol),a

	inc		hl
	inc		hl

-:	ldi				; copy key label to buffer
	bit		7,(hl)
	jr		z,{-}

	call	REDEF._keytobuf	; render key name to buffer at de

	xor		a
	ld		b,20
-:	ld		(de),a	; write at 20 spaces after key
	inc		de
	djnz	{-}

	pop		de		; advace buffer pointer
	ld		hl,20
	add		hl,de
	ex		de,hl

	ret

_backmsg:
	.asc "hit space to go back"

helpscn:
	ld		hl,help
	ld		de,dfile
	call	decrunch

	ld		hl,_backmsg
	ld		de,offscreenmap
	ld		bc,20
	ldir

	ld		de,offscreenmap + 20 ; arbitrary buffer
	ld		hl,REDEF._upk
	call	renderKey
	ld		hl,REDEF._dnk
	call	renderKey
	ld		hl,REDEF._lfk
	call	renderKey
	ld		hl,REDEF._rtk
	call	renderKey
	ld		hl,REDEF._frk
	call	renderKey
	ld		hl,_backmsg
	ld		bc,20
	ldir
	ld		hl,_backmsg
	ld		bc,20
	ldir

_helploop:
	call	framesync

	ld		hl,(frames)
	sla		l
	rl		h
	sla		l
	rl		h
	ld		a,h
	and		7
	add		a,a
	add		a,a		; * 4
	ld		l,a
	add		a,a
	add		a,a		; * 16
	add		a,l		; * 20
	ld		l,a
	ld		h,offscreenmap/256
	ld		de,dfile+$2FE
	ld		bc,20
	ldir


	call	readtitleinput

	ld		a,(begin)
	and		3
	cp		1
	jr		nz,_helploop

	ret

