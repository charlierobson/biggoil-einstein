;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module SFX

;
; DANGER WILL ROBINSON!
;
; The effects sound bank is modified at run time.
;
; effect 18 is dynamically generated in order to make the retract
; sound's increasing pitsh. this data below is changed each frame
; then written back into the effect bank by the 'generatetone'
; function.
;
; if the effects mank is changed be sure to either lock effect 18
; in place or make appropriate modifications to the code.
;
newtone:
newtonep1=newtone+1
newtonep2=newtone+5
newtonep3=newtone+8
newtonep4=newtone+11
	.byte   $EF,$F9,$03,$00,$AD,$03,$02,$AA,$2D,$01,$A7,$FB,$00,$D0,$20
	.byte   $EF,$F9,$03,$00,$AD,$03,$02,$AA,$2D,$01,$A7,$FB,$00,$D0,$20



initsfx:
	call	framesync
	call	mute_ay
	ld		hl,AYFX.FRAME
	ld		(irqsnd),hl
	ld		hl,soundbank
	call	AYFX.INIT
	ret


; haha this is cheeky.
;
longplay:
	ld		(droneframe),a			; prevent drone from taking over for the duration of this effect
	ld		a,b
	jp		AYFX.PLAYON3


initdrone:
	ld		a,(level)				; level is 0..7 incl
	rlca
	rlca							; 0 .. 16
	ld		b,a
	ld		a,40					; 40 .. 24
	sub		b
	ld		(dronerate),a
	xor		a
	ld		(dronetype),a
	ld		(droneframe),a
	ret
		

drone:
	ld		a,(droneframe)
	and		a
	jr		z,_dronetime

	dec		a
	ld		(droneframe),a
	ret

_dronetime:
	ld		a,(dronerate)
	ld		(droneframe),a
	ld		a,(dronetype)
	xor		1
	ld		(dronetype),a
	add		a,15
	jp		AYFX.PLAYON3

droneframe:
	.byte	0
dronerate:
	.byte	0
dronetype:
	.byte	0



resettone:
	ld		hl,newtone+15
	ld		de,newtone
	ld		bc,15
	ldir
	ret

generatetone:
	push	af
	dec		a						; effect number in A
	call	updatetone
	ld 		h,0
	ld 		l,a
	add	 	hl,hl
	ld 		bc,soundbank+1
	add 	hl,bc
	ld 		c,(hl)
	inc 	hl
	ld 		b,(hl)
	add 	hl,bc					;the effect address is obtained in hl
	ld		de,newtone
	ex		de,hl
	ld		bc,15
	ldir							; overwrite the tone in the bank with the modified one
	pop		af
	jp		AYFX.PLAY


updatetone:
	ld		de,12
	ld		hl,(newtonep1)
	sbc		hl,de
	ld		(newtonep1),hl
	ld		hl,(newtonep2)
	sbc		hl,de
	ld		(newtonep2),hl
	ld		hl,(newtonep3)
	sbc		hl,de
	ld		(newtonep3),hl
	ld		hl,(newtonep4)
	sbc		hl,de
	ld		(newtonep4),hl
	ret
