	.module AYFX

; SN76489 version of AYFX player by SirMorris, 2018
; AY-3-8910 original by Shiru and AlCo, 2006-2007

; data structure
;
; cmd+vol (byte)	[TN--vvvv]				T = tone update, N = noise update
; note    (word)	[xxxxllll][xxmmmmmm]	data present only if T=1. l = lsb, m = msb
; noise   (byte)	[xxxxxwnn]				data present only if N=1. w=1 whitenoise, nn = noise rate

PSGBASE = 0

CHAN_ADDR:		.equ	0	;(W) current addr. channel is free if MSB = 0
CHAN_TIME:		.equ	2	;(B) current play time
CHAN_NOISE		.equ	3	;(B) noise flag
CHAN_ID:		.equ	4	;(B) channel mask used, to build register data

CHAN_SIZE = 5

CHAN1 = 0
CHAN2 = CHAN_SIZE
CHAN3 = CHAN_SIZE*2

CHAN1ID = 0<<5
CHAN2ID = 1<<5
CHAN3ID = 2<<5
CHAN4ID = 3<<5

_BIT_T			.equ	7
_BIT_N			.equ	6
_BIT_DRONE		.equ	5


;=====================================
; INIT
;=====================================
INIT:
	xor		a								; silence all channels
	ld		(afxChDesc+CHAN1+CHAN_ADDR+1),a
	ld		(afxChDesc+CHAN1+CHAN_NOISE),a
	ld		(afxChDesc+CHAN2+CHAN_ADDR+1),a
	ld		(afxChDesc+CHAN2+CHAN_NOISE),a
	ld		(afxChDesc+CHAN3+CHAN_ADDR+1),a
	ld		(afxChDesc+CHAN3+CHAN_NOISE),a

	ld		a,CHAN1ID+$9f
	out		(PSGBASE),a
	ld		a,CHAN2ID+$9f
	out		(PSGBASE),a
	ld		a,CHAN3ID+$9f
	out		(PSGBASE),a
	ld		a,CHAN4ID+$9f
	out		(PSGBASE),a

;	ld		a,$e5						; (don't!) start the noise
;	out		(PSGBASE),a

	ret


;=====================================
; FRAME
; ISR routine to generate sound.
;=====================================
FRAME:
	ld		ix,afxChDesc+CHAN1
	call	_processChan
	ld		ix,afxChDesc+CHAN2
	call	_processChan
	ld		ix,afxChDesc+CHAN3
	call	_processChan

_processNoise:
	ret

	; not happy with noise processing so far, need a 'real' player.

	ld		ix,afxChDesc+CHAN_NOISE
	ld		a,(ix+CHAN1)
	or		(ix+CHAN2)
	or		(ix+CHAN3)
	ld		a,$9f+CHAN4ID
	jr		z,{+}
	and		$f7
+:	out		(PSGBASE),a
	ret



_processChan:
	ld		h,(ix+CHAN_ADDR+1)		; channel data address MSB
	dec		h
	inc		h
	ret		z						; nothing to do if msb is 0

	ld		l,(ix+CHAN_ADDR)		; get sfx address low byte
	ld		e,(hl)					; cmd + volume
	inc		hl

	ld		a,e
	and		15
	or		(ix+CHAN_ID)
	or		$90
	out		(PSGBASE),a					; chan volume

	ld		a,e						; vol has been set, wa2s this the effect terminator?
	cp		$3f
	jr		nz,_channelContinues

	ld		(ix+CHAN_ADDR+1),0
	ld		(ix+CHAN_NOISE),0
	ret

_channelContinues:
	inc		(ix+CHAN_TIME)

	bit		_BIT_T,e				; check if we have new tone val
	jr		z,_checkNoise

	ld		a,(hl)					; get 4 ls bits
	inc		hl
	or		(ix+CHAN_ID)
	or		$80
	out		(PSGBASE),a					; chan tone lsb

	ld		a,(hl)					; get 6 ms bits
	inc		hl
	out		(PSGBASE),a					; chan tone msb

	bit		_BIT_DRONE,e			; if this is a drone then return w/o updating pointers
	ret		nz

_checkNoise:
	bit		_BIT_N,e				; any noise to do?
	jr		z,_updatePtr

_doNoise:
	ld		a,(hl)					; get noise enable and stash for this channel
	inc		hl
	ld		(ix+CHAN_NOISE),a

_updatePtr:
	ld		(ix+CHAN_ADDR),l
	ld		(ix+CHAN_ADDR+1),h
	ret


;=====================================
; PLAY
; Start playback of an SFX on CH 1/2
; HL = sfx data
;=====================================
PLAY:
	; find an empty channel
	;
	ld		a,(afxChDesc+CHAN1+CHAN_ADDR+1)
	and		a
	jr		z,_playon1

	ld		a,(afxChDesc+CHAN2+CHAN_ADDR+1)
	and		a
	jr		nz,_useOldest

_playon2:
	xor		a
	ld		(afxChDesc+CHAN2+CHAN_TIME),a
	ld		(afxChDesc+CHAN2+CHAN_ADDR),hl
	ret

_useOldest:
	ld		a,(afxChDesc+CHAN2+CHAN_TIME)
	ld		b,a
	ld		a,(afxChDesc+CHAN1+CHAN_TIME)
	sub		b
	jr		c,_playon2

_playon1:
	xor		a
	ld		(afxChDesc+CHAN2+CHAN_TIME),a
	ld		(afxChDesc+CHAN1+CHAN_ADDR),hl
	ret


;====================================================
; DRONEON3
; Start playback of an uninterruptable effect / drone
; HL = sfx data
;====================================================
DRONEON3:
	;
	; a drone on ch3 will only interrupt another drone
	;
	ld		ix,afxChDesc+CHAN3
	ld		e,(ix+CHAN_ADDR)
	ld		d,(ix+1+CHAN_ADDR)
	inc		d
	dec		d
	jr		z,PLAYON3					; channel is free so play

	ld		a,(de)
	bit		_BIT_DRONE,a				; bail if not replacing another drone
	ret		z

;====================================================
; PLAYON3
; HL = sfx data
;====================================================
PLAYON3:
	ld		(afxChDesc+CHAN3+CHAN_ADDR),hl
	ret

;====================================================
; PLAYON2
; HL = sfx data
;====================================================
PLAYON2:
	ld		(afxChDesc+CHAN2+CHAN_ADDR),hl
	ret

;====================================================
; PLAYON2
; HL = sfx data
;====================================================
PLAYON1:
	ld		(afxChDesc+CHAN1+CHAN_ADDR),hl
	ret
