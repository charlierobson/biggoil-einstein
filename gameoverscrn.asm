gameoverscn: 
	ld		hl,end
	ld		de,dfile
	call	decrunch

	di

	call	init_stc			; set up the music player

	ld		hl,play_stc
	ld		(playfn),hl

	ld		a,16
	ld		(pl_current_position),a
	call	next_pattern

	ei

	ld		a,150
	ld		(timeout),a

;;;;	call	AYFX.INIT

_endloop:
	call	framesync
	call	readinput

	ld		a,(pl_current_position)
	cp		18
;;;;	call	z,initsfx

	ld		a,(fire)
	and		3
	cp		1
	ret		z

	ld		a,(timeout)
	dec		a
	ld		(timeout),a
	jr		nz,_endloop
	ret
