    .org $100

#include "gamedefs.asm"


start:
    di
	ld		sp,$7fff

    ld      hl,$7000    ; zero out memory
    ld      de,$7001
    ld      (hl),l
    ld      bc,$ff0
    ldir

    call    initirq     ; repurpose the ctc channel 2&3 irq for 20ms, also clears pending irqs using reti

    call    initVDP
	call	seedrnd

    ei

-:	call	titlescn
	call	game
	call	gameoverscn
	jr		{-}


; irq function for music update. disabled by disabling interrupts.
;
initirq:
    ; (50 * 16) * 100 = 80000
    ; 80000 / 4000000 = 0.02 sec or 20ms or 1/50th sec

    ld      hl,irqfn    ; install own handler
    ld      ($fb06),hl

    LD      C,2AH       ; IO port for ctc channel 2
    LD      A,1FH       ; disable interrupt + timer mode + prescaler 16 + rising edge + clk starts + time constant follows + reset + control
    LD      B,32H       ; tc = 50
    CALL    {+}
    INC     C           ; io port for ctc channel 3
    LD      A,0DFH      ; enable interrupt + counter mode + (n/a) + rising edge + clk starts + time constant follows + reset + control
    LD      B,64H       ; tc = 100
+:  OUT     (C),A
    NOP
    OUT     (C),B
    RETI


irqfn:
    di
    exx
    push    af

    ld      hl,(frames)
    inc     hl
    ld      (frames),hl

    ; read the keyboard

	ld		bc,$08fe        ; 8 rows, mask in c
    ld      hl,keystates
    ld      d,0             ; all keys OR'd together

-:  LD		A,0EH
	OUT		(PSG_SEL),A
	ld		a,c
    rlc     c
	OUT		(PSG_WR),A
	LD		A,0FH           ; read key row
	OUT		(PSG_SEL),A
	IN		A,(PSG_RD)
	CPL                     ; active low->hi
    ld      (hl),a
    inc     hl
    or      d
    ld      d,a
    djnz    {-}

    ld      a,d
    ld      (keystates+8),a

playfn = $+1
    call    _dummy
    call    psg_reset_io

    pop     af
    exx
    ei

    reti



psg_reset_io:
    ld      a,7                 ; set bit 6 of register 7
    out     (PSG_SEL),a         ; this is to ensure the continued working
    nop
    in      a,(PSG_SEL)         ; of the keyboard on the einstein
    or      $40
    out     (PSG_WR),a
_dummy:
    ret


    ; todo: move this
    .align  256
keystates:
    .ds     9


;-------------------------------------------------------------------------------


#include "charmap.asm"

#include "titlescrn.asm"
#include "helpscrn.asm"
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
#include "ayfxplay.asm"
#include "sfx.asm"
#include "stcplay.asm"

#include "font.asm"

#include "seg_data.asm"

    .end

