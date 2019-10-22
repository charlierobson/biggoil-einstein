    .org $100

#include "gamedefs.asm"


start:
	ld		sp,$7fff

    ld      hl,$7000                ; zero out memory
    ld      de,$7001
    ld      (hl),l
    ld      bc,$ff0
    ldir

    call    initVDP
	call	seedrnd
    call    clrirq                  ; simply a reti instruction, used to satisfy z80 family chips

-:	call	titlescn
	call	game
	call	gameoverscn
	jr		{-}


clrirq:
    reti


;-------------------------------------------------------------------------------


#include "charmap.asm"

#include "titlescrn.asm"
#include "redefine.asm"
#include "game.asm"
#include "gameoverscrn.asm"

#include "player.asm"
#include "enemies.asm"
#include "whimsy.asm"
#include "score.asm"

#include "leveldata.asm"

#include "random.asm"
#include "decrunch.asm"
#include "input.asm"
#include "vdp.asm"
#include "ayfxplayAY.asm"
#include "sfx.asm"
#include "stcplay.asm"

#include "font.asm"

#include "seg_data.asm"

    .end

