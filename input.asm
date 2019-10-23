;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module INPUT

; for kb description see hardware manual, fig 3.5, section 3.8


; input state data:
;
; key row select
; key mask
; joystick bit mask from port $37, or 0 if no js
; trigger impulse

titleinputstates:
	.byte	$01,%01000000,%00000000,0		; startgame    (SP)
	.byte	$20,%00001000,%00000000,0		; redefine     (R)
	.byte	$02,%00000001,%00000000,0		; instructions (I)
	.byte	$00,%00000000,%00000000,0		; jsbegin	(--)

gameinputstates:
	.byte	$01,%01000000,%00000000,0		; fire	    (SP)
	.byte	$20,%01000000,%00000010,0		; up	    (Q)
	.byte	$40,%01000000,%00001000,0		; down	    (A)
	.byte	$08,%00000001,%00000100,0		; left	    (,)
	.byte	$08,%00000010,%00000001,0		; right	    (.)
	.byte	$00,%00000000,%00000000,0		; jsfire    (--)

; calculate actual input impulse addresses
;
begin	= titleinputstates + 3
redef	= titleinputstates + 7
insts	= titleinputstates + 11
jsbegin	= titleinputstates + 15

fire	= gameinputstates + 3
up		= gameinputstates + 7
down	= gameinputstates + 11
left	= gameinputstates + 15
right	= gameinputstates + 19
jsfire	= gameinputstates + 23


prepTitleInputs:
	ld		b,3
	ld		hl,titleinputstates+3
	jr		_prepinputs

prepGameInputs:
	ld		b,6
	ld		hl,gameinputstates+3

_prepinputs:
	ld		de,4

-:	ld		(hl),$ff
	add		hl,de
	djnz	{-}

	ld		a,$ff				; no joystick but I'll leave this here in case
	ld		(lastJ),a
	ret



readtitleinput:
	ld		hl,titleinputstates
	call	updateinputstate ; (begin)
	call	updateinputstate ; (redefine)
	jp		updateinputstate ; (instructs)


readinput:
	ld		hl,gameinputstates
	call	updateinputstate ; (up)
	call	updateinputstate ; (down)
	call	updateinputstate ; (left)
	call	updateinputstate ; (right)
	call	updateinputstate ; (fire)

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
