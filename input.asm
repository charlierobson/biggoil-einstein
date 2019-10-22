;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module INPUT


PSG	=	00H		;PSG	00-07 	AY-3-8910
PSG_SEL = 02H	;LATCH ADDRESS
PSG_RD	= 02H	;READ FROM PSG
PSG_WR	= 03H	;WRITE TO PSG

; for kb description see hardware manual, fig 3.5, section 3.8

prepTitleInputs:
	ld		hl,titleinputstates+3
	jr		_prepinputs

prepGameInputs:
	ld		hl,gameinputstates+3

_prepinputs:
	ld		de,4
	ld		b,5

-:	ld		(hl),$ff
	add		hl,de
	djnz	{-}

	ld		a,$ff				; no joystick but I'll leave this here in case
	ld		(lastJ),a
	ret



readtitleinput:
	ld		hl,titleinputstates
	call	updateinputstate ; (begin)
	jp		updateinputstate ; (redefine)


readinput:
	ld		hl,gameinputstates
	call	updateinputstate ; (up)
	call	updateinputstate ; (down)
	call	updateinputstate ;  etc.
	call	updateinputstate ;
	call	updateinputstate ;

	; fall into here for last input

updateinputstate:
	; hl points at first input state block,
	; return from update function pointing to next
	;
    LD		A,0EH
	OUT		(PSG_SEL),A
	ld		a,(hl)					; get key row selector
	CPL								; make it active low
	OUT		(PSG_WR),A

	LD		A,0FH					; read key row
	OUT		(PSG_SEL),A
	IN		A,(PSG_RD)
	CPL								; active low->hi

	inc		hl						; point to row mask
	and		(hl)					; result will be non-zero if required key is down

	; note - all JS stuff is redundant, for now, but left here in case

	inc		hl						; points at js mask
	ld		b,$ff					; match-all mask
	jr		nz,{+}					; skip joystick read if key pressed

	ld		b,(hl)					; get j/s mask
	ld		a,(lastJ)				; no key was detected, so test stick

+:	inc		hl						; point at key state
	sla		(hl)					; (key & 3) = 0 - not pressed, 1 - just pressed, 2 - just released and >3 - held

	and		b						; if a key was already detected A&B will be !0
	jr		z,{+}					; else js bit was just tested

	set		0,(hl)					; signify impulse

+:	inc		hl						; ready for next read
	ret
