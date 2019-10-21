initdrone:
	ld		a,(level)				; level is 0..3 incl
	and		3
	rlca
	rlca							; 0,4,8,12
	ld		b,a
	ld		a,40					; 40,36,32,28
	sub		b
	ld		(dronerate),a
	xor		a
	ld		(droneframe),a
	ret

drone:
	ld		hl,drone1
	call	AYFX.DRONEON3

	ld		a,(droneframe)
	dec		a
	ld		(droneframe),a
	ret		p

	ld		a,(dronerate)
	ld		(droneframe),a
	ld		a,(drone1+1)
	xor		$0f
	ld		(drone1+1),a
	ret



resettone:
	ld		hl,newtone+newtonelen
	ld		de,newtone
	ld		bc,newtonelen
	ldir
	ret


generatetone:
	ld		hl,newtonep1
	call	{+}
	ld		hl,newtonep2
	call	{+}
	ld		hl,newtonep3
	call	{+}
	ld		hl,newtonep4
	call	{+}
	ld		hl,newtone
	jp		AYFX.PLAYON1

+:	ld		e,0				; alter lsb
	ld		a,(hl)
	sub		12
	rl		e				; stash carry
	and		15				; isolate lsbits (clears carry)
	ld		(hl),a
	dec		e
	ret		m				; return now if no carry

	inc		hl				; otherwise alter msbits
	ld		a,(hl)
	dec		a
	and		$3f
	ld		(hl),a
	ret




smfx3: ; 'hello' - enemy appears
    .incbin    "data/3.smfx"

smfx4: ; drill - eat oil
    .incbin    "data/4.smfx"

smfx7: ; pipe popped / life lost
    .incbin    "data/7.smfx"

smfx12: ; level clear
    .incbin    "data/12.smfx"

smfx13: ; game over
    .incbin    "data/13.smfx"

smfx14: ; enemy eaten
    .incbin    "data/14.smfx"

smfx17: ; drill - move
    .incbin    "data/17.smfx"

smfx10: ; extra live
    .incbin    "data/10.smfx"
