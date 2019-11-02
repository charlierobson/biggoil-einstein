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

redefi:
	.incbin data/redef.binlz

help:
	.incbin data/instructions.binlz

soundbank:
	.incbin data/biggoil.afb

titlestc:
	.incbin data/yerz.stc


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


; where the variables live
;
keycol			.db 0 
keyrow  		.db 0 
keyaddress  	.dw 0 
tcd  			.db 0 
tt  			.db 0 
frames  		.db 0 
soundEnable 	.db 0 
winchframe  	.db 0 
playerpos  		.dw 0 
oldplayerpos	.dw 0 
playerhit  		.db 0 
playerdirn  	.dw 0 
retractptr  	.dw 0 
timerv  		.db 0 
scoretoadd  	.db 0 
score  			.dw 0 
hiscore  		.dw 0 
lives  			.db 0 
entrancecount	.db 0 
level  			.db 0 
timeout  		.db 0 
cldfrm  		.db 0 
generatimer 	.db 0 
leveltrig  		.db 0 
lx  			.db 0 
rndseed  		.dw 0 
psound  		.dw 0 
headchar  		.db 0 
fuelchar  		.db 0 
afxNoise  		.db 0 
enemydata		.ds ENEMYSIZE*NENEMIES



; dfile is mirrored at +$400 bytes further on in memory,
; this is to allow quick indexing into the map by setting
; a single bit in the dfile pointer, bit 2 of H reg.
;
dfile = $7000
offscreenmap = $7400		;	dfile + $400


; retractqueue code requires a 'backstop' - the byte at retractqueue-1 is used.
;
retractqueue = $7900

; calculated at run time
;
entrances = $7a00
