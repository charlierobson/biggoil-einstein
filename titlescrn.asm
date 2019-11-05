;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
.module TSC

_tt1:
	.asc	" space to start "
_tt2:
	.asc	"r - redefine key"
_tt3:
	.asc	"i - instructions"

	.align	8
_ttbl:
	.dw		_tt1,_tt2,_tt1,_tt3



titlescn:
	di
	call	init_stc			; set up the music player
	ei

	ld		hl,play_stc
	ld		(playfn),hl

	call	titlerestart

	ld		hl,mute_ay
	ld		(playfn),hl

	ret



titlerestart:
	ld		hl,title
	ld		de,dfile
	call	decrunch
	call	displayscoreonts
	call	displayhionts

_titleloop:
	call	framesync
	call	readtitleinput

	ld		a,(frames)
	rlca
	rlca
	and		3
	add		a,a
	ld		hl,_ttbl
	or		l
	ld		l,a
	ld		a,(hl)
	inc		hl
	ld		h,(hl)
	ld		l,a

	ld		de,dfile+$300
	ld		bc,16
	ldir

	ld		a,(frames)
	and		16
	jr		nz,_noflash

	ld		hl,dfile+$300
	ld		b,16
_ilop:
	ld		a,(hl)
	xor		$80
	ld		(hl),a
	inc		hl
	djnz	_ilop

_noflash:
	ld		a,(insts)
	and		3
	cp		1
	jr		nz,{+}

	call	helpscn
	call	waitVSync
	jp		titlerestart

+:	ld		a,(redef)
	and		3
	cp		1
	jr		nz,{+}

	call	redefinekeys
	call	waitVSync
	jp		titlerestart

+:	ld		a,(begin)
	and		3
	cp		1
	jr		nz,_titleloop

	ret
