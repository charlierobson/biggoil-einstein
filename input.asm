;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module INPUT

; for kb description see hardware manual, fig 3.5, section 3.8


; input state data:
;
; key row
; key mask
; joystick bit mask (unused, left in case I implement it)
; trigger impulse / key state

titleinputstates:
	.byte	$00,%01000000,0		; startgame    (SP)
	.byte	$05,%00001000,0		; redefine     (R)
	.byte	$01,%00000001,0		; instructions (I)

gameinputstates:
	.byte	$00,%01000000,0		; fire	    (SP)
	.byte	$05,%01000000,0		; up	    (Q)
	.byte	$06,%01000000,0		; down	    (A)
	.byte	$03,%00000001,0		; left	    (,)
	.byte	$03,%00000010,0		; right	    (.)

; calculate actual input impulse addresses
;
begin	= titleinputstates + 2
redef	= titleinputstates + 5
insts	= titleinputstates + 8
jsbegin	= titleinputstates + 11

fire	= gameinputstates + 2
up		= gameinputstates + 5
down	= gameinputstates + 8
left	= gameinputstates + 11
right	= gameinputstates + 14



prepTitleInputs:
	ld		b,3
	ld		hl,begin
	jr		_prepinputs

prepGameInputs:
	ld		b,6
	ld		hl,fire

_prepinputs:
	ld		de,3

-:	ld		(hl),$ff
	add		hl,de
	djnz	{-}

	ret



readtitleinput:
	ld		hl,titleinputstates
	call	updateinputstate ; (begin)
	call	updateinputstate ; (redefine)
	jp		updateinputstate ; (instructs)


readinput:
	ld		hl,gameinputstates
	call	updateinputstate ; (fire)
	call	updateinputstate ; (up)
	call	updateinputstate ; (down)
	call	updateinputstate ; (left)

	; fall into here for last input (right)

updateinputstate:
	; hl points at first input state block,
	; return from update function pointing to next
	;
	ld		e,(hl)					; get key row selector
	ld		d,keystates/256
	ld		a,(de)
	inc		hl						; point to row mask
	and		(hl)					; result will be non-zero if required key is down

	inc		hl						; point at key state
	sla		(hl)					; (key & 3) = 0 - not pressed, 1 - just pressed, 2 - just released and >3 - held

	and		a						; if a key was already detected A will be !0
	jr		z,{+}					; else js bit was just tested

	set		0,(hl)					; signify impulse

+:	inc		hl						; ready for next read
	ret
