initmem:
	; clear mem up to the expected stack bottom
	;
	ld		hl,$7000	; base of 4K RAM in M5
	ld		de,$7001	; 
	ld		bc,$0ff8	; leave stack alone
	xor		a
	ld		(hl),a
	ldir

	; copy readwrite data to ram
	;
    ld      hl,seg_data
    ld      de,seg_data_target
    ld      bc,seg_data_end - seg_data
    ldir
	ret


level1:
	.incbin data/lvl1.binlz

level2:
	.incbin	data/lvl2.binlz

level3:
	.incbin	data/lvl3.binlz

level4:
	.incbin	data/lvl4.binlz

title:
	.incbin data/title.binlz

end:
	.incbin data/end.binlz


	.align 16
reversetab:
	.word   33,-1,-33,0,1

; the turntable tells us which character should be 
; displayed at a pipe junction. we make an index
; from the last direction and the latest direction.
; current dir << 3 + new dir
; see UP, DOWN etc in gamedefs.
;
; up -> up = 0
; up -> right = 1
; up -> left = 4
; right -> up = 8
; etc. etc.
;
	.align 256
turntable:
	.byte   $85,$85,$00,$00,$84,$00,$00,$00
	.byte   $03,$03,$84,$00,$00,$00,$00,$00
	.byte   $00,$02,$85,$00,$03,$00,$00,$00
	.byte   $00,$00,$00,$00,$00,$00,$00,$00
	.byte   $02,$00,$85,$00,$03,$00,$00,$00
	.byte   $00,$00,$00,$00,$00,$00,$00,$00

	.align  16
winchanim:
	.byte   $00,$01
	.byte   $00,$04
	.byte   $87,$00
	.byte   $02,$00

	.align	64
leveldata:
	.word	level1, level2, level3, level4

	.align 16
enemyanims:
;	.byte   $10,$13     ; (<
;	.byte   $11,$12     ; >)
	.byte   $0c,$8c     ; £
	.byte   $0c,$8c     ; £



scoreline:
	.byte	$38, $28, $34, $37, $2a, $0e, $1c, $1c, $1c, $1c, $1c, $00, $2d, $2e, $0e, $1c, $1c, $1c, $1c, $1c, $00, $31, $3b, $31, $0e, $1d, $00, $32, $2a, $33, $0e, $20


	.align  128
clouds:
	.byte	$00, $0a, $08, $09, $00, $00, $00, $00, $00, $00, $00, $0a, $0a, $09, $09, $00, $00, $00, $08, $08, $0a, $00, $00, $00, $00, $00, $00, $09, $08, $08, $0a, $00
	.byte	$00, $00, $00, $09, $09, $00, $00, $00, $00, $0a, $08, $00, $00, $00, $00, $09, $0a, $00, $00, $00, $09, $09, $08, $00, $00, $00, $00, $00, $00, $0a, $09, $00
	.byte	$00, $0a, $08, $09, $00, $00, $00, $00, $00, $00, $00, $0a, $0a, $09, $09, $00, $00, $00, $08, $08, $0a, $00, $00, $00, $00, $00, $00, $09, $08, $08, $0a, $00


; dfile is mirrored at +$400 bytes further on in memory,
; this is to allow quick indexing into the map by setting
; a single bit in the dfile pointer, bit 2 of H reg.
;
dfile = $7020
offscreenmap = $7420		;	dfile + $400

; initialised data goes here, in space between dfile & offscreen
seg_data_target = $7340		;	dfile + $300 + $20

; uninitialised data goes here
seg_bss_target = $7800
seg_bss_size = $f0


; retractqueue code requires a 'backstop' - the byte at retractqueue-1 is used.
;
retractqueue = $7900
entrances = $7a00

seg_data:
.relocate seg_data_target

; input state data:
;
; key row select
; key mask
; joystick bit mask from port $37, or 0 if no js
; trigger impulse

titleinputstates:
	.byte	$01,%01000000,%00000000,0		; startgame	(SP)
	.byte	$20,%00001000,%00000000,0		; redefine	(R)
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
jsbegin	= titleinputstates + 11

fire	= gameinputstates + 3
up		= gameinputstates + 7
down	= gameinputstates + 11
left	= gameinputstates + 15
right	= gameinputstates + 19
jsfire	= gameinputstates + 23

newtone:
newtonep1=newtone+1
newtonep2=newtone+4
newtonep3=newtone+7
newtonep4=newtone+10
	.byte   $80,$09,$3f,$82,$03,$20,$85,$0D,$12,$88,$0B,$0f,$3f
newtonelen = $-newtone
	.byte   $80,$09,$3f,$82,$03,$20,$85,$0D,$12,$88,$0B,$0f,$3f

afxChDesc:
	.db		0,0,0,0,CHAN1ID
	.db		0,0,0,0,CHAN2ID
	.db		0,0,0,0,CHAN3ID

drone1:
    .byte       %10101100
    .byte       $0f,$3f

; =-=-=-=-= self-modifying codez =-=-=-=-=


; called from initentrances in leveldata
;
addv:
	ld		(hl),e
	inc		hl
	ld		(hl),d
	inc		hl
adval0 = $+1
	ld		(hl),0
	inc		hl
adval1 = $+1
	ld		(hl),0
	inc		hl
animnum = $+1
	ld		(hl),0
	inc		hl
	inc		hl
	inc		hl
	inc		hl

	ld		a,(entrancecount)
	inc		a
	ld		(entrancecount),a
	ret


.if $ >= offscreenmap
.fail "relocatable data is too large to fit the gap"
.endif

.endrelocate
seg_data_end



seg_bss:
.varloc seg_bss_target,seg_bss_size
	.var	byte, lastJ
	.var	byte, keycol
	.var	byte, keyrow
	.var	word, keyaddress
	.var	byte, tcd
	.var	byte, tt
	.var	byte, frames
	.var	byte, winchframe
	.var	word, playerpos
	.var	word, oldplayerpos
	.var	byte, playerhit
	.var	word, playerdirn
	.var	word, retractptr
	.var	byte, timerv
	.var	byte, scoretoadd
	.var	word, score
	.var	word, hiscore
	.var	byte, lives
	.var	byte, entrancecount
	.var	byte, level
	.var	byte, timeout
	.var	byte, cldfrm
	.var	byte, generatimer
	.var	byte, leveltrig
	.var	byte, lx
	.var	word, rndseed
	.var	word, psound
	.var	byte, headchar
	.var	byte, fuelchar
	.var	byte, droneframe
	.var	byte, dronerate
	.var	byte, afxNoise
	.var	byte[ENEMYSIZE*NENEMIES], enemydata
