    .org $100

#include "gamedefs.asm"


start:
    di
	ld		sp,$7fff

    ; ld      a,$01                   ; disable timer interrupts
    ; out     ($01),a

    call    initmem
    call    initVDP

	call	seedrnd

    ; ld      hl,vbl                    ; redirect irq routine
    ; ld      ($7006),hl

    call    clrirq                  ; simply a reti instruction, used to satisfy z80 family chips
    ei

-:	call	titlescn
	call	game
	call	gameoverscn
	jr		{-}




vdpIRQ:
    ; exx
    ; push    af
    ; ld      a,(frames)
    ; inc     a
    ; ld      (frames),a

    ; call    AYFX.FRAME

    ; in      a,(VDP_STAT)
    ; pop     af
    ; exx
    ; ei

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

