    .org $100

    ld      sp,$7fff
    
    ld      a,7
    out     (2),a

    ld      a,$43
    out     (3),a

    ld      a,6
    out     (2),a

    ld      a,$00
    out     (3),a

    ld      a,7
    out     (2),a

    .db     $cf,$a6
    .db     $cf,$a6

    in      a,(2)
    .db     $cf,$aa

    in      a,(3)
    .db     $cf,$aa
    .db     $cf,$a6
    ret


