.define DB .db
.define DW .dw
.define ORG .org

  ORG 2000h
  DB 02h
  DW 2007h
  DW 2D7Bh
  DW 2D7Bh


        ORG     2007h

        ; Entry Point
        ; --- START PROC L2007 ---
L2007:  DI

        LD      SP,7300h      ; initialise vdp
        LD      HL,208Ch
        LD      BC,1011h
        OTIR

        LD      HL,2081h      ; install vsync irq
        LD      (7006h),HL

        CALL    L27BF
        CALL    L2AF4
        LD      HL,7300h
        LD      DE,7301h
        LD      BC,00FFh
        LD      (HL),00h
        LDIR
        LD      HL,20D2h
        LD      DE,7300h
        LD      BC,0030h
        LDIR
        CALL    L3EEF
        CALL    L2CD8
        CALL    L22EA
        LD      A,0FFh
        LD      (733Dh),A
        LD      HL,0301h
        LD      (733Eh),HL
        LD      A,01h
        LD      (7335h),A
        LD      HL,2DF0h
        LD      (7400h),HL
L2056:  EI
        LD      HL,(7330h)
        DEC     L
        JR      NZ,L2056
        INC     H
        LD      (7330h),HL
        LD      HL,7F00h
        LD      DE,7F00h
        LD      BC,0080h
        CALL    L3EF8
        CALL    L2C57
        CALL    L2D29
        CALL    L33BC
        CALL    L3E37
        CALL    L3D60
        CALL    L2315
        JR      L2056

        ; Entry Point
        ; --- START PROC L2081 ---
L2081:  EX      AF,AF'
        IN      A,(11h)
        LD      A,01h
        LD      (7330h),A
        EX      AF,AF'
        RETI

L208C:  DB      01h
        DB      80h
        DB      0E2h
        DB      81h
        DB      0Fh
        DB      82h
        DB      0FEh
        DB      83h
        DB      05h
        DB      84h
        DB      7Eh             ; '~'
        DB      85h
        DB      04h
        DB      86h
        DB      01h
        DB      87h

        ; Entry Point
        ; --- START PROC L209C ---
L209C:  CALL    L20A6
        PUSH    AF
        CALL    L20A6
        POP     HL
        LD      L,A
        RET

        ; --- START PROC L20A6 ---
L20A6:  LD      HL,(737Eh)
        LD      A,L
        ADD     A,A
        ADD     A,A
        LD      A,L
        INC     A
        LD      L,A
        LD      A,H
        AND     90h
        JR      Z,L20B8
        XOR     90h
        JR      NZ,L20B9
L20B8:  SCF
L20B9:  LD      A,H
        RLA
        LD      H,A
        LD      (737Eh),HL
        ADD     A,L
        RET

        ; Entry Point
        ; --- START PROC L20C1 ---
L20C1:  IN      A,(50h)         ; 'P'
        RLCA
        LD      HL,7378h
        LD      A,(HL)
        RLA
        LD      (HL),A
        AND     03h
        DEC     A
        RET     NZ
        LD      (7392h),A
        RET

L20D2:  DB      0EBh
        DB      0BEh
        DB      82h
        DB      28h             ; '('
        DB      0C3h
        DB      3Ch             ; '<'
        DB      0AAh
        DB      0AAh
        DB      0C5h
        DB      3Ah             ; ':'
        DB      00h
        DB      3Ch             ; '<'
        DB      0AAh
        DB      0AAh
        DB      0AAh
        DB      0AAh
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      0F0h
        DB      60h             ; '`'
        DB      50h             ; 'P'
        DB      0D0h
        DB      0A0h
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      0B0h
        DB      90h
        DB      50h             ; 'P'
        DB      50h             ; 'P'
        DB      90h
        DB      "PPP<B"
        DB      99h
        DB      0A1h
        DB      0A1h
        DB      99h
        DB      42h             ; 'B'
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      0Fh
        DB      3Fh             ; '?'
        DB      70h             ; 'p'
        DB      40h             ; '@'
        DB      70h             ; 'p'
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      0E0h
        DB      76h             ; 'v'
        DB      19h
        DB      71h             ; 'q'
        DB      7Fh
        DB      7Fh
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      1Fh
        DB      0Fh
        DB      07h
        DB      00h
        DB      0F1h
        DB      0F6h
        DB      0F8h
        DB      0E0h
        DB      0C0h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      1Dh
        DB      3Eh             ; '>'
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      00h
        DB      00h
        DB      00h
        DB      70h             ; 'p'
        DB      0F8h
        DB      0FCh
        DB      0FCh
        DB      0FCh
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      1Fh
        DB      1Fh
        DB      0Fh
        DB      06h
        DB      00h
        DB      00h
        DB      0ECh
        DB      0ECh
        DB      0D8h
        DB      0F8h
        DB      0F0h
        DB      0E0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      1Eh
        DB      3Bh             ; ';'
        DB      00h
        DB      00h
        DB      0Ch
        DB      3Ch             ; '<'
        DB      0D0h
        DB      10h
        DB      " @>-5"
        DB      1Dh
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      0B0h
        DB      0B8h
        DB      0F8h
        DB      78h             ; 'x'
        DB      98h
        DB      0F0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      1Fh
        DB      3Fh             ; '?'
        DB      72h             ; 'r'
        DB      72h             ; 'r'
        DB      07h
        DB      0Ch
        DB      00h
        DB      00h
        DB      0F8h
        DB      0FCh
        DB      4Eh             ; 'N'
        DB      4Eh             ; 'N'
        DB      0E0h
        DB      30h             ; '0'
        DB      08h
        DB      19h
        DB      19h
        DB      38h             ; '8'
        DB      3Ch             ; '<'
        DB      3Fh             ; '?'
        DB      00h
        DB      00h
        DB      10h
        DB      98h
        DB      98h
        DB      5Ch             ; '\'
        DB      3Ch             ; '<'
        DB      0FCh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      02h
        DB      07h
        DB      01h
        DB      02h
        DB      02h
        DB      00h
        DB      78h             ; 'x'
        DB      84h
        DB      8Ch
        DB      7Ch             ; '|'
        DB      9Eh
        DB      7Eh             ; '~'
        DB      0FEh
        DB      0Dh
        DB      1Dh
        DB      3Fh             ; '?'
        DB      7Fh
        DB      7Fh
        DB      7Fh
        DB      3Fh             ; '?'
        DB      00h
        DB      0FEh
        DB      0FEh
        DB      0FCh
        DB      0F0h
        DB      0C0h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      03h
        DB      0Fh
        DB      1Fh
        DB      1Fh
        DB      3Eh             ; '>'
        DB      3Fh             ; '?'
        DB      00h
        DB      00h
        DB      0C0h
        DB      0F0h
        DB      0F8h
        DB      0F8h
        DB      0FCh
        DB      7Ch             ; '|'
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      1Fh
        DB      0Ch
        DB      03h
        DB      07h
        DB      00h
        DB      00h
        DB      7Ch             ; '|'
        DB      7Ch             ; '|'
        DB      78h             ; 'x'
        DB      0B0h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      00h
        DB      19h
        DB      3Fh             ; '?'
        DB      37h             ; '7'
        DB      19h
        DB      06h
        DB      20h             ; ' '
        DB      0C0h
        DB      00h
        DB      98h
        DB      0FCh
        DB      74h             ; 't'
        DB      98h
        DB      60h             ; '`'
        DB      0Fh
        DB      0Dh
        DB      06h
        DB      01h
        DB      03h
        DB      03h
        DB      01h
        DB      00h
        DB      0F0h
        DB      0D0h
        DB      60h             ; '`'
        DB      80h
        DB      0C0h
        DB      40h             ; '@'
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      03h
        DB      06h
        DB      06h
        DB      0Fh
        DB      00h
        DB      18h
        DB      0F4h
        DB      0F8h
        DB      38h             ; '8'
        DB      7Ch             ; '|'
        DB      0FCh
        DB      0FCh
        DB      0Fh
        DB      1Fh
        DB      30h             ; '0'
        DB      38h             ; '8'
        DB      1Dh
        DB      03h
        DB      03h
        DB      00h
        DB      0FCh
        DB      0FCh
        DB      8Eh
        DB      86h
        DB      9Ch
        DB      78h             ; 'x'
        DB      00h
        DB      00h
        DB      0FFh
        DB      0FFh
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0FFh
        DB      0FFh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0FFh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      07h
        DB      0Fh
        DB      0Fh
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      0Fh
        DB      0Fh
        DB      1Fh
        DB      1Fh
        DB      00h
        DB      03h
        DB      0Fh
        DB      1Fh
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      7Fh
        DB      7Fh
        DB      00h
        DB      00h
        DB      03h
        DB      07h
        DB      03h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      0F0h
        DB      0F8h
        DB      0F8h
        DB      0FCh
        DB      7Ch             ; '|'
        DB      07h
        DB      1Fh
        DB      0Fh
        DB      07h
        DB      03h
        DB      01h
        DB      00h
        DB      00h
        DB      0E0h
        DB      0F8h
        DB      0FCh
        DB      0FEh
        DB      0FEh
        DB      0FFh
        DB      0FFh
        DB      7Fh
        DB      00h
        DB      00h
        DB      03h
        DB      0Fh
        DB      1Fh
        DB      0Fh
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      0F0h
        DB      0F8h
        DB      0F8h
        DB      0FCh
        DB      0FCh
        DB      07h
        DB      1Fh
        DB      3Fh             ; '?'
        DB      7Fh
        DB      3Fh             ; '?'
        DB      0Fh
        DB      03h
        DB      00h
        DB      0E0h
        DB      0F8h
        DB      0FCh
        DB      0FEh
        DB      0FEh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      00h
        DB      00h
        DB      03h
        DB      0Fh
        DB      1Fh
        DB      1Fh
        DB      "??????6"
        DB      22h             ; '"'
        DB      00h
        DB      00h
        DB      "????;"
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C1h
        DB      0C1h
        DB      0CFh
        DB      0C7h
        DB      0C3h
        DB      0C7h
        DB      0C6h
        DB      0C4h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      0C0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      07h
        DB      1Fh
        DB      3Fh             ; '?'
        DB      3Fh             ; '?'
        DB      7Fh
        DB      7Fh
        DB      7Fh
        DB      66h             ; 'f'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      7Fh
        DB      7Fh
        DB      7Fh
        DB      39h             ; '9'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      07h
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      16h
        DB      12h
        DB      00h
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Fh
        DB      1Dh
        DB      09h
        DB      00h

        ; --- START PROC L22EA ---
L22EA:  LD      HL,2482h
        LD      DE,7610h
        LD      BC,000Bh
        LDIR
        LD      HL,7620h
        LD      BC,1800h
L22FB:  LD      (HL),C
        INC     L
        DJNZ    L22FB
        LD      DE,2020h
        LD      (7640h),DE
        LD      (7642h),DE
        LD      HL,7600h
        LD      BC,1000h
L2310:  LD      (HL),C
        INC     L
        DJNZ    L2310
        RET

        ; --- START PROC L2315 ---
L2315:  LD      HL,7610h
        LD      BC,0B20h
        OTIR
        LD      HL,7640h
        LD      DE,7600h
        LD      BC,0606h
        CALL    L2351
        BIT     5,(HL)
        JR      NZ,L2330
        JP      L2344

L2330:  INC     L
        LD      DE,7606h
        LD      BC,040Ah
        CALL    L2351
        INC     L
        LD      DE,760Ah
        LD      BC,0610h
        CALL    L2351
L2344:  LD      HL,7600h
        LD      BC,0B00h
L234A:  LD      (HL),C
        INC     L
        DJNZ    L234A
        JP      L236B

        ; --- START PROC L2351 ---
L2351:  LD      A,(DE)
        AND     A
        JR      NZ,L2359
        INC     E
        DJNZ    L2351
        RET

L2359:  LD      A,C
        SUB     B
        LD      B,A
        LD      A,(HL)
        BIT     5,A
        JR      NZ,L2366
        AND     1Fh
        CP      B
        RET     C
        RET     Z
L2366:  LD      A,B
        ADD     A,80h
        LD      (HL),A
        RET

        ; --- START PROC L236B ---
L236B:  LD      HL,7640h
        LD      DE,7610h
        LD      IX,7620h
        LD      BC,0200h
        LD      A,(HL)
        BIT     5,A
        JR      NZ,L23A2
        BIT     7,A
        JR      Z,L239E
        LD      A,20h           ; ' '
        LD      (7641h),A
        LD      (7642h),A
        LD      (7643h),A
        LD      A,9Fh
        LD      (7612h),A
        LD      A,0BFh
        LD      (7615h),A
        LD      A,0DFh
        LD      (7618h),A
        CALL    L23BF
L239E:  CALL    L23E7
        RET

L23A2:  INC     L
L23A3:  LD      A,(HL)
        BIT     7,A
        CALL    NZ,L23BF
        LD      A,(HL)
        BIT     6,A
        CALL    NZ,L23E7
        PUSH    HL
        EX      DE,HL
        LD      DE,0003h
        ADD     HL,DE
        LD      E,08h
        ADD     IX,DE
        EX      DE,HL
        POP     HL
        INC     L
        DJNZ    L23A3
        RET

        ; --- START PROC L23BF ---
L23BF:  PUSH    BC
        PUSH    HL
        PUSH    DE
        LD      A,(HL)
        SUB     40h             ; '@'
        LD      (HL),A
        ADD     A,A
        ADD     A,A
        LD      C,A
        LD      A,B
        ADD     A,A
        LD      E,A
        LD      D,00h
        LD      HL,23E1h
        ADD     HL,DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      B,00h
        LD      HL,24A5h
        ADD     HL,BC
        LD      C,04h
        LDIR
        POP     DE
        POP     HL
        POP     BC
        RET

        ; Entry Point
        ; --- START PROC L23E3 ---
L23E3:  JR      Z,L245B
        JR      NZ,L245D
        ; --- START PROC L23E7 ---
L23E7:  PUSH    BC
        PUSH    HL
        PUSH    DE
        LD      A,(IX+06h)
        AND     A
        JP      NZ,L244F
        LD      L,(IX+00h)
        LD      H,(IX+01h)
        INC     HL
        LD      A,(HL)
        LD      (IX+06h),A
        INC     HL
        LD      (IX+00h),L
        LD      (IX+01h),H
        DEC     HL
        DEC     HL
        LD      A,(HL)
        INC     A
        JP      Z,L246E
        DEC     A
        LD      C,A
        AND     0Fh
        JP      Z,L2449
        DEC     A
        LD      B,A
        LD      A,C
        AND     0F0h
        RRCA
        RRCA
        RRCA
        LD      E,A
        LD      D,00h
        LD      HL,248Dh
        ADD     HL,DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
L2424:  ADD     HL,HL
        DJNZ    L2424
        LD      A,L
        RRCA
        RRCA
        RRCA
        RRCA
        AND     0Fh
        LD      B,A
        POP     DE
        PUSH    DE
        LD      A,(DE)
        AND     0F0h
        ADD     A,B
        LD      (DE),A
        INC     E
        LD      A,H
        LD      (DE),A
        DEC     E
        LD      A,(IX+02h)
        LD      (IX+04h),A
        LD      A,(IX+03h)
        LD      (IX+05h),A
        JP      L244F

L2449:  LD      (IX+04h),0E5h
        POP     DE
        PUSH    DE
L244F:  INC     E
        INC     E
        LD      A,(DE)
        AND     0F0h
        LD      B,A
        LD      L,(IX+04h)
        LD      H,(IX+05h)
        ; --- START PROC L245B ---
L245B:  LD      A,(HL)
        ;AND     0Fh
        DB      0E6h
        ; --- START PROC L245D ---
L245D:  RRCA
        ADD     A,B
        LD      (DE),A
        INC     HL
        LD      (IX+04h),L
        LD      (IX+05h),H
        DEC     (IX+06h)
        POP     DE
        POP     HL
        POP     BC
        RET

        ; --- START PROC L246E ---
L246E:  POP     DE
        POP     HL
        LD      A,(HL)
        SUB     20h             ; ' '
        LD      (HL),A
        INC     E
        INC     E
        LD      A,(DE)
        OR      0Fh
        LD      (DE),A
        DEC     E
        DEC     E
        XOR     A
        LD      (IX+06h),A
        POP     BC
        RET

L2482:  DB      80h
        DB      00h
        DB      9Fh
        DB      0A0h
        DB      00h
        DB      0BFh
        DB      0C0h
        DB      00h
        DB      0DFh
        DB      0E0h
        DB      0FFh
        DB      0FCh
        DB      01h
        DB      0DEh
        DB      01h
        DB      0C4h
        DB      01h
        DB      0ABh
        DB      01h
        DB      93h
        DB      01h
        DB      7Dh             ; '}'
        DB      01h
        DB      67h             ; 'g'
        DB      01h
        DB      53h             ; 'S'
        DB      01h
        DB      40h             ; '@'
        DB      01h
        DB      2Eh             ; '.'
        DB      01h
        DB      1Dh
        DB      01h
        DB      0Dh
        DB      01h
        DB      25h             ; '%'
        DB      25h             ; '%'
        DB      0F5h
        DB      24h             ; '$'
        DB      5Ch             ; '\'
        DB      25h             ; '%'
        DB      0F5h
        DB      24h             ; '$'
        DB      7Dh             ; '}'
        DB      25h             ; '%'
        DB      0F5h
        DB      24h             ; '$'
        DB      0E8h
        DB      25h             ; '%'
        DB      05h
        DB      25h             ; '%'
        DB      5Fh             ; '_'
        DB      26h             ; '&'
        DB      05h
        DB      25h             ; '%'
        DB      70h             ; 'p'
        DB      26h             ; '&'
        DB      05h
        DB      25h             ; '%'
        DB      0B1h
        DB      26h             ; '&'
        DB      05h
        DB      25h             ; '%'
        DB      0D0h
        DB      26h             ; '&'
        DB      05h
        DB      25h             ; '%'
        DB      0E5h
        DB      26h             ; '&'
        DB      05h
        DB      25h             ; '%'
        DB      0FEh
        DB      26h             ; '&'
        DB      05h
        DB      25h             ; '%'
        DB      1Bh
        DB      27h             ; '''
        DB      05h
        DB      25h             ; '%'
        DB      3Ch             ; '<'
        DB      27h             ; '''
        DB      15h
        DB      25h             ; '%'
        DB      4Fh             ; 'O'
        DB      27h             ; '''
        DB      15h
        DB      25h             ; '%'
        DB      5Ah             ; 'Z'
        DB      27h             ; '''
        DB      15h
        DB      25h             ; '%'
        DB      73h             ; 's'
        DB      27h             ; '''
        DB      15h
        DB      25h             ; '%'
        DB      94h
        DB      27h             ; '''
        DB      15h
        DB      25h             ; '%'
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      00h
        DB      01h
        DB      02h
        DB      03h
        DB      04h
        DB      05h
        DB      06h
        DB      07h
        DB      07h
        DB      07h
        DB      07h
        DB      07h
        DB      07h
        DB      07h
        DB      07h
        DB      07h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      02h
        DB      94h
        DB      0Ch
        DB      0A4h
        DB      04h
        DB      33h             ; '3'
        DB      08h
        DB      73h             ; 's'
        DB      08h
        DB      0A3h
        DB      08h
        DB      0A3h
        DB      08h
        DB      0A3h
        DB      10h
        DB      0A4h
        DB      0Ch
        DB      0B4h
        DB      04h
        DB      43h             ; 'C'
        DB      08h
        DB      83h
        DB      08h
        DB      0B3h
        DB      08h
        DB      0B3h
        DB      08h
        DB      0B3h
        DB      10h
        DB      94h
        DB      0Ch
        DB      0A4h
        DB      04h
        DB      33h             ; '3'
        DB      08h
        DB      73h             ; 's'
        DB      08h
        DB      0A3h
        DB      08h
        DB      0A3h
        DB      08h
        DB      0A3h
        DB      10h
        DB      83h
        DB      08h
        DB      63h             ; 'c'
        DB      10h
        DB      43h             ; 'C'
        DB      08h
        DB      33h             ; '3'
        DB      08h
        DB      33h             ; '3'
        DB      08h
        DB      33h             ; '3'
        DB      10h
        DB      0FFh
        DB      34h             ; '4'
        DB      08h
        DB      34h             ; '4'
        DB      08h
        DB      34h             ; '4'
        DB      08h
        DB      04h
        DB      04h
        DB      0A5h
        DB      04h
        DB      34h             ; '4'
        DB      08h
        DB      64h             ; 'd'
        DB      08h
        DB      84h
        DB      08h
        DB      94h
        DB      08h
        DB      83h
        DB      08h
        DB      63h             ; 'c'
        DB      08h
        DB      33h             ; '3'
        DB      08h
        DB      63h             ; 'c'
        DB      08h
        DB      33h             ; '3'
        DB      08h
        DB      0C0h
        DB      08h
        DB      35h             ; '5'
        DB      08h
        DB      0FFh
        DB      34h             ; '4'
        DB      08h
        DB      34h             ; '4'
        DB      08h
        DB      34h             ; '4'
        DB      08h
        DB      04h
        DB      04h
        DB      0A5h
        DB      04h
        DB      34h             ; '4'
        DB      08h
        DB      64h             ; 'd'
        DB      08h
        DB      84h
        DB      08h
        DB      94h
        DB      08h
        DB      0A3h
        DB      02h
        DB      0B3h
        DB      02h
        DB      0A3h
        DB      02h
        DB      93h
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      93h
        DB      02h
        DB      0A3h
        DB      02h
        DB      93h
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      83h
        DB      02h
        DB      93h
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      23h             ; '#'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      84h
        DB      08h
        DB      74h             ; 't'
        DB      08h
        DB      0C0h
        DB      08h
        DB      35h             ; '5'
        DB      08h
        DB      0FFh
        DB      0A3h
        DB      02h
        DB      0B3h
        DB      02h
        DB      0A3h
        DB      02h
        DB      93h
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      93h
        DB      02h
        DB      0A3h
        DB      02h
        DB      93h
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      83h
        DB      02h
        DB      93h
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      83h
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      73h             ; 's'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      63h             ; 'c'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      23h             ; '#'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      43h             ; 'C'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      23h             ; '#'
        DB      02h
        DB      13h
        DB      02h
        DB      85h
        DB      01h
        DB      04h
        DB      01h
        DB      44h             ; 'D'
        DB      01h
        DB      84h
        DB      01h
        DB      03h
        DB      01h
        DB      43h             ; 'C'
        DB      01h
        DB      83h
        DB      01h
        DB      02h
        DB      01h
        DB      0C0h
        DB      02h
        DB      85h
        DB      01h
        DB      04h
        DB      01h
        DB      44h             ; 'D'
        DB      01h
        DB      84h
        DB      01h
        DB      03h
        DB      01h
        DB      43h             ; 'C'
        DB      01h
        DB      83h
        DB      01h
        DB      02h
        DB      01h
        DB      0FFh
        DB      33h             ; '3'
        DB      06h
        DB      32h             ; '2'
        DB      06h
        DB      0A3h
        DB      06h
        DB      73h             ; 's'
        DB      06h
        DB      32h             ; '2'
        DB      06h
        DB      0A3h
        DB      06h
        DB      0C0h
        DB      06h
        DB      12h
        DB      10h
        DB      0FFh
        DB      05h
        DB      01h
        DB      45h             ; 'E'
        DB      01h
        DB      85h
        DB      01h
        DB      0A5h
        DB      01h
        DB      05h
        DB      01h
        DB      25h             ; '%'
        DB      01h
        DB      45h             ; 'E'
        DB      01h
        DB      65h             ; 'e'
        DB      01h
        DB      85h
        DB      01h
        DB      0A5h
        DB      01h
        DB      04h
        DB      01h
        DB      14h
        DB      01h
        DB      24h             ; '$'
        DB      01h
        DB      34h             ; '4'
        DB      01h
        DB      44h             ; 'D'
        DB      01h
        DB      54h             ; 'T'
        DB      01h
        DB      64h             ; 'd'
        DB      01h
        DB      74h             ; 't'
        DB      01h
        DB      84h
        DB      01h
        DB      94h
        DB      01h
        DB      0A4h
        DB      01h
        DB      0B4h
        DB      01h
        DB      03h
        DB      01h
        DB      23h             ; '#'
        DB      01h
        DB      43h             ; 'C'
        DB      01h
        DB      63h             ; 'c'
        DB      01h
        DB      83h
        DB      01h
        DB      0A3h
        DB      01h
        DB      02h
        DB      01h
        DB      32h             ; '2'
        DB      01h
        DB      62h             ; 'b'
        DB      01h
        DB      92h
        DB      01h
        DB      0FFh
        DB      74h             ; 't'
        DB      02h
        DB      84h
        DB      02h
        DB      0A4h
        DB      02h
        DB      03h
        DB      02h
        DB      23h             ; '#'
        DB      02h
        DB      84h
        DB      02h
        DB      0A4h
        DB      02h
        DB      03h
        DB      02h
        DB      23h             ; '#'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      0A4h
        DB      02h
        DB      03h
        DB      02h
        DB      23h             ; '#'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      53h             ; 'S'
        DB      02h
        DB      0FFh
        DB      04h
        DB      01h
        DB      12h
        DB      02h
        DB      24h             ; '$'
        DB      03h
        DB      32h             ; '2'
        DB      01h
        DB      44h             ; 'D'
        DB      02h
        DB      52h             ; 'R'
        DB      03h
        DB      44h             ; 'D'
        DB      01h
        DB      32h             ; '2'
        DB      02h
        DB      24h             ; '$'
        DB      03h
        DB      12h
        DB      01h
        DB      0FFh
        DB      0B6h
        DB      02h
        DB      0B3h
        DB      02h
        DB      05h
        DB      04h
        DB      63h             ; 'c'
        DB      02h
        DB      15h
        DB      02h
        DB      13h
        DB      04h
        DB      25h             ; '%'
        DB      02h
        DB      84h
        DB      02h
        DB      35h             ; '5'
        DB      04h
        DB      34h             ; '4'
        DB      02h
        DB      45h             ; 'E'
        DB      02h
        DB      95h
        DB      04h
        DB      0FFh
        DB      04h
        DB      01h
        DB      44h             ; 'D'
        DB      01h
        DB      74h             ; 't'
        DB      01h
        DB      0A4h
        DB      01h
        DB      03h
        DB      01h
        DB      23h             ; '#'
        DB      01h
        DB      0C0h
        DB      02h
        DB      23h             ; '#'
        DB      01h
        DB      03h
        DB      01h
        DB      0A4h
        DB      01h
        DB      74h             ; 't'
        DB      01h
        DB      44h             ; 'D'
        DB      01h
        DB      04h
        DB      01h
        DB      0C0h
        DB      01h
        DB      0FFh
        DB      33h             ; '3'
        DB      08h
        DB      53h             ; 'S'
        DB      08h
        DB      73h             ; 's'
        DB      08h
        DB      83h
        DB      08h
        DB      0A3h
        DB      08h
        DB      02h
        DB      08h
        DB      22h             ; '"'
        DB      08h
        DB      32h             ; '2'
        DB      08h
        DB      33h             ; '3'
        DB      08h
        DB      53h             ; 'S'
        DB      08h
        DB      73h             ; 's'
        DB      08h
        DB      83h
        DB      08h
        DB      0A3h
        DB      08h
        DB      02h
        DB      08h
        DB      22h             ; '"'
        DB      08h
        DB      32h             ; '2'
        DB      08h
        DB      0FFh
        DB      02h
        DB      04h
        DB      83h
        DB      04h
        DB      12h
        DB      04h
        DB      93h
        DB      04h
        DB      22h             ; '"'
        DB      04h
        DB      0A3h
        DB      04h
        DB      32h             ; '2'
        DB      04h
        DB      0B3h
        DB      04h
        DB      0C0h
        DB      03h
        DB      0FFh
        DB      35h             ; '5'
        DB      02h
        DB      25h             ; '%'
        DB      02h
        DB      0A5h
        DB      02h
        DB      0B5h
        DB      02h
        DB      0C0h
        DB      03h
        DB      0FFh
        DB      84h
        DB      01h
        DB      0A4h
        DB      01h
        DB      03h
        DB      01h
        DB      33h             ; '3'
        DB      01h
        DB      53h             ; 'S'
        DB      01h
        DB      73h             ; 's'
        DB      01h
        DB      53h             ; 'S'
        DB      01h
        DB      33h             ; '3'
        DB      01h
        DB      03h
        DB      01h
        DB      0A4h
        DB      01h
        DB      84h
        DB      01h
        DB      0C0h
        DB      02h
        DB      0FFh
        DB      84h
        DB      01h
        DB      94h
        DB      01h
        DB      0B4h
        DB      01h
        DB      03h
        DB      01h
        DB      13h
        DB      01h
        DB      33h             ; '3'
        DB      01h
        DB      43h             ; 'C'
        DB      01h
        DB      53h             ; 'S'
        DB      01h
        DB      33h             ; '3'
        DB      01h
        DB      23h             ; '#'
        DB      01h
        DB      13h
        DB      01h
        DB      0B4h
        DB      01h
        DB      0A4h
        DB      01h
        DB      94h
        DB      01h
        DB      74h             ; 't'
        DB      01h
        DB      0C0h
        DB      03h
        DB      0FFh
        DB      84h
        DB      01h
        DB      94h
        DB      01h
        DB      0A4h
        DB      01h
        DB      0B4h
        DB      01h
        DB      03h
        DB      01h
        DB      13h
        DB      01h
        DB      23h             ; '#'
        DB      01h
        DB      33h             ; '3'
        DB      01h
        DB      43h             ; 'C'
        DB      01h
        DB      53h             ; 'S'
        DB      01h
        DB      43h             ; 'C'
        DB      01h
        DB      33h             ; '3'
        DB      01h
        DB      23h             ; '#'
        DB      01h
        DB      13h
        DB      01h
        DB      03h
        DB      01h
        DB      0B4h
        DB      01h
        DB      0A4h
        DB      01h
        DB      94h
        DB      01h
        DB      84h
        DB      01h
        DB      74h             ; 't'
        DB      01h
        DB      0C0h
        DB      04h
        DB      0FFh

        ; --- START PROC L27BF ---
L27BF:  LD      C,40h           ; '@'
        LD      DE,7800h
L27C4:  LD      B,10h
        LD      HL,2824h
        CALL    L2B29
        LD      A,C
        ADD     A,10h
        LD      C,A
        CP      80h
        JR      NZ,L27C4

        LD      BC,1000h
        CALL    L2B29
        LD      HL,7A40h
        LD      BC,0100h
        LDIR
        LD      HL,2844h
        LD      BC,1000h
        CALL    L2B29
        LD      HL,7B80h
        LD      BC,0080h
        LDIR
        LD      HL,2874h
        LD      BC,0280h
        LDIR
        LD      DE,7A40h
        LD      HL,2854h
        LD      C,09h
L2803:  CALL    L2815
        DEC     C
        JR      NZ,L2803
        LD      HL,7800h
        LD      DE,6000h
        LD      BC,0800h
        JP      L3EF8

        ; --- START PROC L2815 ---
L2815:  PUSH    HL
        CALL    L281A
        POP     HL
        ; --- START PROC L281A ---
L281A:  LD      B,20h           ; ' '
L281C:  LD      A,(DE)
        XOR     (HL)
        LD      (DE),A
        INC     DE
        INC     HL
        DJNZ    L281C
        RET

L2824:  DB      0Ch
        DB      0Ah
        DB      04h
        DB      02h
        DB      07h
        DB      0Ah
        DB      03h
        DB      0Dh
        DB      00h
        DB      05h
        DB      08h
        DB      0Dh
        DB      0Ch
        DB      01h
        DB      08h
        DB      06h
        DB      "ljhm|zx}"
        DB      80h
        DB      88h
        DB      84h
        DB      8Ch
        DB      80h
        DB      90h
        DB      84h
        DB      94h
        DB      0B0h
        DB      0B8h
        DB      0B4h
        DB      0BCh
        DB      0B0h
        DB      0C0h
        DB      0B4h
        DB      0C4h
        DB      0C8h
        DB      0D0h
        DB      0CCh
        DB      0D4h
        DB      0C8h
        DB      0D8h
        DB      0CCh
        DB      0DCh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      00h
        DB      00h
        DB      09h
        DB      16h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      00h
        DB      90h
        DB      68h             ; 'h'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      04h
        DB      05h
        DB      05h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      60h             ; '`'
        DB      90h
        DB      0B0h
        DB      0B0h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      06h
        DB      0Fh
        DB      09h
        DB      06h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      0E0h
        DB      20h             ; ' '
        DB      0C0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      06h
        DB      09h
        DB      0Dh
        DB      0Dh
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      20h             ; ' '
        DB      0A0h
        DB      0A0h
        DB      40h             ; '@'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      04h
        DB      07h
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      60h             ; '`'
        DB      90h
        DB      0F0h
        DB      60h             ; '`'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      03h
        DB      05h
        DB      05h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      30h             ; '0'
        DB      0D8h
        DB      18h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      06h
        DB      06h
        DB      05h
        DB      05h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      0C0h
        DB      40h             ; '@'
        DB      40h             ; '@'
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ch
        DB      1Bh
        DB      19h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C0h
        DB      0A0h
        DB      0A0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      02h
        DB      02h
        DB      03h
        DB      03h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      0A0h
        DB      0A0h
        DB      60h             ; '`'
        DB      60h             ; '`'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      31h             ; '1'
        DB      4Ah             ; 'J'
        DB      0Ah
        DB      12h
        DB      22h             ; '"'
        DB      42h             ; 'B'
        DB      79h             ; 'y'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      8Ch
        DB      "RRRRR"
        DB      8Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      11h
        DB      32h             ; '2'
        DB      52h             ; 'R'
        DB      92h
        DB      0FAh
        DB      12h
        DB      11h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      8Ch
        DB      "RRRRR"
        DB      8Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      "1JJ2JJ1"
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      8Ch
        DB      "RRRRR"
        DB      8Ch
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      88h
        DB      91h
        DB      0A1h
        DB      0B9h
        DB      0A5h
        DB      0A5h
        DB      98h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0C6h
        DB      ")))))"
        DB      0C6h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      67h             ; 'g'
        DB      95h
        DB      15h
        DB      25h             ; '%'
        DB      45h             ; 'E'
        DB      85h
        DB      0F7h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      "wUUUUUw"
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F7h
        DB      85h
        DB      85h
        DB      0E5h
        DB      15h
        DB      15h
        DB      15h
        DB      0E7h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      "wUUUUUUw"
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      "`px|~??"
        DB      1Fh
        DB      07h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Ch
        DB      1Ch
        DB      3Ch             ; '<'
        DB      7Ch             ; '|'
        DB      0FCh
        DB      0F8h
        DB      0F8h
        DB      0F0h
        DB      0C0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F0h
        DB      0FCh
        DB      0FFh
        DB      7Fh
        DB      3Fh             ; '?'
        DB      0Eh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Eh
        DB      7Eh             ; '~'
        DB      0FEh
        DB      0FCh
        DB      0F8h
        DB      0E0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0Fh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      7Fh
        DB      1Eh
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0E0h
        DB      0FEh
        DB      0FEh
        DB      0FCh
        DB      0F0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      03h
        DB      0Fh
        DB      1Fh
        DB      7Fh
        DB      7Eh             ; '~'
        DB      3Ch             ; '<'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      0E0h
        DB      0F0h
        DB      0FCh
        DB      0FCh
        DB      78h             ; 'x'
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      01h
        DB      03h
        DB      03h
        DB      03h
        DB      07h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      80h
        DB      80h
        DB      0C0h
        DB      80h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      04h
        DB      02h
        DB      10h
        DB      08h
        DB      00h
        DB      30h             ; '0'
        DB      00h
        DB      08h
        DB      12h
        DB      04h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      40h             ; '@'
        DB      90h
        DB      20h             ; ' '
        DB      00h
        DB      18h
        DB      00h
        DB      20h             ; ' '
        DB      10h
        DB      80h
        DB      40h             ; '@'
        DB      00h
        DB      00h

        ; --- START PROC L2AF4 ---
L2AF4:  LD      HL,2102h
        LD      DE,7C58h
        LD      BC,0108h
        LDIR
        LD      HL,2BF3h
        LD      BC,4400h
        CALL    L2B29
        LD      HL,7E80h
L2B0B:  LD      DE,2C37h
        LD      B,20h           ; ' '
L2B10:  LD      A,(DE)
        OR      (HL)
        INC     H
        LD      (HL),A
        DEC     H
        INC     L
        INC     DE
        DJNZ    L2B10
        LD      A,L
        AND     A
        JR      NZ,L2B0B
        LD      HL,7C58h
        LD      DE,6C58h
        LD      BC,03A8h
        JP      L3EF8

        ; --- START PROC L2B29 ---
L2B29:  PUSH    BC
        PUSH    HL
        PUSH    DE
        CALL    L2B3E
        POP     DE
        LD      HL,7300h
        LD      BC,0008h
        LDIR
        POP     HL
        POP     BC
        INC     HL
        DJNZ    L2B29
        RET

        ; --- START PROC L2B3E ---
L2B3E:  LD      A,(HL)
        AND     0F8h
        ADD     A,C
        LD      DE,220Ah
        ADD     A,E
        LD      E,A
        JR      NC,L2B4A
        INC     D
L2B4A:  LD      A,(HL)
        AND     07h
        ADD     A,A
        LD      HL,2B5Bh
        ADD     A,L
        LD      L,A
        JR      NC,L2B56
        INC     H
L2B56:  LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        JP      (HL)

        ; Entry Point
        ; --- START PROC L2B5B ---
L2B5B:  LD      L,E
        DEC     HL
        LD      (HL),L
        DEC     HL
        ADC     A,B
        DEC     HL
        SBC     A,E
        DEC     HL
        XOR     (HL)
        DEC     HL
        POP     BC
        DEC     HL
        CALL    0E02Bh
        DEC     HL
        ; Entry Point
        ; --- START PROC L2B6B ---
L2B6B:  EX      DE,HL
        LD      DE,7300h
        LD      BC,0008h
        LDIR
        RET

        ; Entry Point
        ; --- START PROC L2B75 ---
L2B75:  LD      C,08h
L2B77:  LD      HL,7300h
        LD      A,(DE)
        LD      B,08h
L2B7D:  RRCA
        RL      (HL)
        INC     HL
        DJNZ    L2B7D
        INC     DE
        DEC     C
        JR      NZ,L2B77
        RET

        ; Entry Point
        ; --- START PROC L2B88 ---
L2B88:  LD      C,08h
        LD      HL,7307h
L2B8D:  LD      A,(DE)
        LD      B,08h
L2B90:  RLCA
        RR      (HL)
        DJNZ    L2B90
        INC     DE
        DEC     HL
        DEC     C
        JR      NZ,L2B8D
        RET

        ; Entry Point
        ; --- START PROC L2B9B ---
L2B9B:  LD      C,08h
L2B9D:  LD      HL,7300h
        LD      A,(DE)
        LD      B,08h
L2BA3:  RLCA
        RR      (HL)
        INC     HL
        DJNZ    L2BA3
        INC     DE
        DEC     C
        JR      NZ,L2B9D
        RET

        ; Entry Point
        ; --- START PROC L2BAE ---
L2BAE:  LD      C,08h
        LD      HL,7300h
L2BB3:  LD      A,(DE)
        LD      B,08h
L2BB6:  RLCA
        RR      (HL)
        DJNZ    L2BB6
        INC     HL
        INC     DE
        DEC     C
        JR      NZ,L2BB3
        RET

        ; Entry Point
        ; --- START PROC L2BC1 ---
L2BC1:  LD      B,08h
        LD      HL,7307h
L2BC6:  LD      A,(DE)
        LD      (HL),A
        DEC     HL
        INC     DE
        DJNZ    L2BC6
        RET

        ; Entry Point
        ; --- START PROC L2BCD ---
L2BCD:  LD      C,08h
L2BCF:  LD      HL,7300h
        LD      A,(DE)
        LD      B,08h
L2BD5:  RRCA
        RR      (HL)
        INC     HL
        DJNZ    L2BD5
        INC     DE
        DEC     C
        JR      NZ,L2BCF
        RET

        ; Entry Point
        ; --- START PROC L2BE0 ---
L2BE0:  LD      C,08h
L2BE2:  LD      HL,7300h
        LD      A,(DE)
        LD      B,08h
L2BE8:  RLCA
        RL      (HL)
        INC     HL
        DJNZ    L2BE8
        INC     DE
        DEC     C
        JR      NZ,L2BE2
        RET

L2BF3:  DB      40h             ; '@'
        DB      48h             ; 'H'
        DB      45h             ; 'E'
        DB      4Dh             ; 'M'
        DB      0Ah
        DB      0Dh
        DB      0Ch
        DB      08h
        DB      "(,-*04528<=:"
        DB      98h
        DB      98h
        DB      98h
        DB      98h
        DB      "(,-* $'!%"
        DB      22h             ; '"'
        DB      23h             ; '#'
        DB      26h             ; '&'
        DB      00h
        DB      04h
        DB      05h
        DB      02h
        DB      08h
        DB      0Ch
        DB      0Dh
        DB      0Ah
        DB      10h
        DB      10h
        DB      15h
        DB      15h
        DB      11h
        DB      13h
        DB      11h
        DB      13h
        DB      18h
        DB      19h
        DB      1Dh
        DB      1Bh
        DB      1Dh
        DB      1Dh
        DB      98h
        DB      98h
        DB      11h
        DB      13h
        DB      11h
        DB      13h
        DB      0A0h
        DB      0A4h
        DB      0A8h
        DB      0ACh
        DB      00h
        DB      00h
        DB      00h
        DB      01h
        DB      06h
        DB      07h
        DB      07h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      60h             ; '`'
        DB      0E0h
        DB      0E0h
        DB      80h
        DB      01h
        DB      01h
        DB      01h
        DB      01h
        DB      01h
        DB      00h
        DB      00h
        DB      00h
        DB      80h
        DB      0C0h
        DB      80h
        DB      0C0h
        DB      80h
        DB      00h
        DB      00h
        DB      00h

        ; --- START PROC L2C57 ---
L2C57:  LD      C,00h
        LD      HL,(7332h)
        CALL    L2CB7
        CALL    L2CC8
        LD      A,C
        LD      (733Ch),A
        CALL    L2C87
        IN      A,(37h)         ; '7'
        OR      E
        LD      C,A
        LD      A,(7332h)
        AND     A
        LD      A,C
        JR      Z,L2C78
        RRCA
        RRCA
        RRCA
        RRCA
L2C78:  LD      B,04h
L2C7A:  RRCA
        JR      C,L2C80
        DJNZ    L2C7A
        RET

L2C80:  LD      A,04h
        SUB     B
        LD      (7458h),A
        RET

        ; --- START PROC L2C87 ---
L2C87:  LD      E,01h
        LD      HL,2CA7h
L2C8C:  LD      C,(HL)
        INC     HL
        LD      B,(HL)
        INC     HL
        IN      A,(C)
        AND     B
        JR      Z,L2C96
        SCF
L2C96:  RL      E
        JR      NC,L2C8C
        LD      A,(7333h)
        AND     A
        RET     NZ
        LD      A,E
        RLCA
        RLCA
        RLCA
        RLCA
        OR      E
        LD      E,A
        RET

L2CA7:  DB      "5 6 6"
        DB      04h
        DB      36h             ; '6'
        DB      40h             ; '@'
        DB      34h             ; '4'
        DB      02h
        DB      33h             ; '3'
        DB      02h
        DB      32h             ; '2'
        DB      04h
        DB      33h             ; '3'
        DB      04h

        ; --- START PROC L2CB7 ---
L2CB7:  LD      A,L
        AND     H
        RET     NZ
        IN      A,(30h)         ; '0'
        AND     05h
        JR      NZ,L2CC5
        IN      A,(31h)         ; '1'
        AND     03h
        RET     Z
        ; --- START PROC L2CC5 ---
L2CC5:  LD      C,01h
        RET

        ; --- START PROC L2CC8 ---
L2CC8:  LD      A,L
        XOR     H
        RET     NZ
        IN      A,(30h)         ; '0'
        AND     48h             ; 'H'
        JR      NZ,L2CC5
        IN      A,(31h)         ; '1'
        AND     30h             ; '0'
        JR      NZ,L2CC5
        RET

        ; --- START PROC L2CD8 ---
L2CD8:  LD      HL,7F00h
        LD      DE,7F80h
        LD      BC,0080h
        LDIR
        LD      HL,7F00h
        LD      HL,00F0h
        LD      (7F00h),HL
        LD      L,00h
        LD      (7F02h),HL
        LD      HL,7F00h
        LD      DE,7F04h
        LD      BC,007Ch
        LDIR
        LD      HL,7400h
        LD      DE,7500h
        LD      BC,0100h
        LDIR
        LD      HL,7400h
        LD      BC,0604h
        CALL    L2D16
        LD      HL,7440h
        LD      BC,0E06h
        ; --- START PROC L2D16 ---
L2D16:  PUSH    BC
        LD      DE,2D7Bh
        LD      (HL),E
        INC     L
        LD      (HL),D
        INC     L
        LD      C,00h
L2D20:  LD      (HL),C
        INC     L
        DJNZ    L2D20
        POP     BC
        DEC     C
        JR      NZ,L2D16
        RET

        ; --- START PROC L2D29 ---
L2D29:  LD      IX,7400h
        LD      B,04h
L2D2F:  PUSH    BC
        PUSH    HL
        CALL    L2D6A
        LD      BC,0008h
        ADD     IX,BC
        POP     HL
        POP     BC
        DJNZ    L2D2F
        LD      IX,7440h
        LD      IY,7F00h
        LD      HL,7450h
        LD      B,05h
L2D4A:  PUSH    BC
        PUSH    HL
        LD      DE,7440h
        LD      BC,0010h
        LDIR
        CALL    L2D6A
        POP     DE
        LD      HL,7440h
        LD      BC,0010h
        LDIR
        EX      DE,HL
        LD      BC,0004h
        ADD     IY,BC
        POP     BC
        DJNZ    L2D4A
        RET

        ; --- START PROC L2D6A ---
L2D6A:  LD      L,(IX+00h)
        LD      H,(IX+01h)
        JP      (HL)

        ; Entry Point
        ; --- START PROC L2D71 ---
L2D71:  POP     HL
        LD      SP,72F8h
        ; --- START PROC L2D75 ---
L2D75:  LD      (IX+00h),L
        LD      (IX+01h),H
        RET

        ; Entry Point
        ; --- START PROC L2D7C ---
L2D7C:  LD      (IX+02h),L
        LD      (IX+03h),H
        POP     HL
        LD      SP,72F8h
        LD      (IX+00h),L
        LD      (IX+01h),H
        JP      (HL)

        ; Entry Point
        ; --- START PROC L2D8D ---
L2D8D:  LD      L,(IX+02h)
        LD      H,(IX+03h)
        DEC     HL
        LD      (IX+02h),L
        LD      (IX+03h),H
        LD      A,L
        OR      H
        JR      Z,L2D71
        ; --- START PROC L2D9E ---
L2D9E:  INC     SP
        INC     SP
        RET

        ; Entry Point
        ; --- START PROC L2DA1 ---
L2DA1:  POP     HL
        LD      SP,72F8h
        LD      (IX+04h),L
        LD      (IX+05h),H
        XOR     A
        LD      (IX+02h),A
        LD      (IX+03h),A
        LD      HL,2DBBh
        LD      (IX+00h),L
        LD      (IX+01h),H
        LD      L,(IX+04h)
        LD      H,(IX+05h)
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        INC     HL
        INC     BC
        LD      A,C
        OR      B
        JR      Z,L2D75
        DEC     BC
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        PUSH    HL
        LD      L,(IX+02h)
        LD      H,(IX+03h)
        AND     A
        SBC     HL,BC
        ADD     HL,BC
        INC     HL
        LD      (IX+02h),L
        LD      (IX+03h),H
        JR      NZ,L2D9E
        CALL    L2DEE
        POP     HL
        LD      (IX+04h),L
        LD      (IX+05h),H
        RET

        ; --- START PROC L2DEE ---
L2DEE:  EX      DE,HL
        JP      (HL)

        ; Entry Point
        ; --- START PROC L2DF0 ---
L2DF0:  LD      A,80h
        LD      (7334h),A
        LD      (733Bh),A
        CALL    L2FA2
        CALL    L2D71
        LD      HL,0000h
        IN      A,(31h)         ; '1'
        AND     11h
        JR      NZ,L2E0D
        IN      A,(31h)         ; '1'
        AND     22h             ; '"'
        RET     Z
        INC     H
L2E0D:  LD      (7332h),HL
        XOR     A
        LD      HL,738Eh
        LD      (HL),A
        INC     L
        LD      (HL),A
        INC     L
        LD      (HL),A
        LD      (7399h),A
        INC     A
        LD      (7334h),A
        LD      (733Bh),A
        LD      (7600h),A
        LD      A,(733Eh)
        LD      (739Ah),A
        LD      A,03h
        LD      (7391h),A
        CALL    L3E94
        CALL    L3053
        LD      HL,7380h
        LD      DE,73C0h
        LD      BC,0040h
        LDIR
        CALL    L2F3F
        CALL    L2F6A
        LD      HL,00B4h
        CALL    L2D7C
        CALL    L2D8D
        ; --- START PROC L2E51 ---
L2E51:  CALL    L2F58
        CALL    L2F7C
        LD      HL,7391h
        DEC     (HL)
        CALL    L3099
L2E5E:  LD      HL,353Eh
        LD      (7450h),HL
        LD      HL,33FDh
        LD      (7408h),HL
        CALL    L2D71
        LD      A,(7392h)
        AND     A
        RET     NZ
        CALL    L3666
        INC     A
        LD      (7601h),A
        CALL    L2CD8
        LD      HL,(7F80h)
        LD      (7F00h),HL
        LD      HL,(7F82h)
        LD      (7F02h),HL
        LD      HL,0078h
        CALL    L2D7C
        CALL    L3F08
        CALL    L2D8D
        LD      HL,00F0h
        LD      (7F00h),HL
        CALL    L3EA2
        CALL    L3053
        LD      HL,003Ch
        CALL    L2D7C
        CALL    L2D8D
        JR      L2E5E

        ; Entry Point
        ; --- START PROC L2EAB ---
L2EAB:  LD      A,(7333h)
        AND     A
        JR      NZ,L2ECB
        LD      A,(7391h)
        AND     A
        JR      NZ,L2EDA
        LD      A,01h
        LD      (7602h),A
        CALL    L2F8E
        LD      HL,00F0h
        CALL    L2D7C
        CALL    L2D8D
        JP      L2DF0

L2ECB:  LD      A,(7391h)
        AND     A
        JR      Z,L2EEF
        LD      A,(73D1h)
        AND     A
        JR      Z,L2EDA
L2ED7:  CALL    L2F25
L2EDA:  CALL    L3062
        CALL    L2F3F
        CALL    L2F6A
        LD      HL,003Ch
        CALL    L2D7C
        CALL    L2D8D
        JP      L2E51

L2EEF:  CALL    L2F3F
        CALL    L2F8E
        LD      A,01h
        LD      (7602h),A
        LD      HL,00B4h
        CALL    L2D7C
        CALL    L2D8D
        CALL    L2F58
        CALL    L2F7C
        LD      A,(73D1h)
        AND     A
        JR      NZ,L2ED7
        CALL    L2F8E
        LD      HL,003Ch
        CALL    L2D7C
        CALL    L2D8D
        LD      A,(7332h)
        AND     A
        CALL    NZ,L2F25
        JP      L2DF0

        ; --- START PROC L2F25 ---
L2F25:  LD      A,(7332h)
        XOR     01h
        LD      (7332h),A
        LD      HL,7380h
        LD      DE,73C0h
        LD      B,40h           ; '@'
L2F35:  LD      C,(HL)
        LD      A,(DE)
        LD      (HL),A
        LD      A,C
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    L2F35
        RET

        ; --- START PROC L2F3F ---
L2F3F:  LD      HL,0169h
        LD      DE,2F50h
        CALL    L3E7F
        LD      A,(7332h)
        ADD     A,31h           ; '1'
        JP      L3DFB

L2F50:  DB      "PLAYER "
        DB      00h

        ; --- START PROC L2F58 ---
L2F58:  LD      HL,0169h
        LD      DE,2F61h
        JP      L3E7F

L2F61:  DB      0D5h
        DB      0D8h
        DB      0D8h
        DB      0D8h
        DB      0D8h
        DB      0D8h
        DB      0D8h
        DB      0D4h
        DB      00h

        ; --- START PROC L2F6A ---
L2F6A:  LD      HL,0189h
        LD      DE,2F73h
        JP      L3E7F

L2F73:  DB      " READY! "
        DB      00h

        ; --- START PROC L2F7C ---
L2F7C:  LD      HL,0189h
        LD      DE,2F85h
        JP      L3E7F

L2F85:  DB      0D7h
        DB      0DAh
        DB      0DAh
        DB      0D6h
        DB      0D7h
        DB      0DAh
        DB      0DAh
        DB      0D6h
        DB      00h

        ; --- START PROC L2F8E ---
L2F8E:  LD      HL,0188h
        LD      DE,2F97h
        JP      L3E7F

L2F97:  DB      "GAME  OVER"
        DB      00h

        ; --- START PROC L2FA2 ---
L2FA2:  LD      HL,0000h
L2FA5:  CALL    L3DF9
        LD      A,H
        CP      03h
        JR      NZ,L2FA5
        LD      HL,0020h
        LD      DE,2FDFh
L2FB3:  LD      A,(DE)
        LD      C,A
        LD      B,08h
L2FB7:  SLA     C
        LD      A,20h           ; ' '
        JR      NC,L2FBF
        LD      A,80h
L2FBF:  CALL    L3DFB
        DJNZ    L2FB7
        INC     DE
        LD      A,H
        CP      02h
        JR      NZ,L2FB3
        LD      DE,301Bh
        LD      HL,0228h
        CALL    L3E7F
        LD      HL,0287h
        CALL    L3E7F
        LD      HL,02C7h
        JP      L3E7F

L2FDF:  DB      3Ch             ; '<'
        DB      72h             ; 'r'
        DB      2Fh             ; '/'
        DB      0BCh
        DB      22h             ; '"'
        DB      8Ah
        DB      28h             ; '('
        DB      22h             ; '"'
        DB      22h             ; '"'
        DB      8Ah
        DB      28h             ; '('
        DB      22h             ; '"'
        DB      3Ch             ; '<'
        DB      8Ah
        DB      0AFh
        DB      3Ch             ; '<'
        DB      20h             ; ' '
        DB      8Ah
        DB      0A8h
        DB      28h             ; '('
        DB      20h             ; ' '
        DB      8Bh
        DB      "h$ r/"
        DB      0A2h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      0F0h
        DB      87h
        DB      00h
        DB      00h
        DB      89h
        DB      48h             ; 'H'
        DB      80h
        DB      00h
        DB      8Ah
        DB      28h             ; '('
        DB      00h
        DB      00h
        DB      0F2h
        DB      28h             ; '('
        DB      00h
        DB      00h
        DB      83h
        DB      0E8h
        DB      00h
        DB      00h
        DB      82h
        DB      28h             ; '('
        DB      80h
        DB      00h
        DB      82h
        DB      27h             ; '''
        DB      00h
        DB      8Bh
        DB      " 1982 NAMCO LTD."
        DB      00h
        DB      "1 PLAYER   "
        DB      22h             ; '"'
        DB      31h             ; '1'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      4Bh             ; 'K'
        DB      45h             ; 'E'
        DB      59h             ; 'Y'
        DB      00h
        DB      "2 PLAYERS  "
        DB      22h             ; '"'
        DB      32h             ; '2'
        DB      22h             ; '"'
        DB      20h             ; ' '
        DB      4Bh             ; 'K'
        DB      45h             ; 'E'
        DB      59h             ; 'Y'
        DB      00h

        ; --- START PROC L3053 ---
L3053:  LD      HL,7380h
        LD      BC,0EFFh
L3059:  LD      (HL),C
        INC     L
        DJNZ    L3059
        LD      A,23h           ; '#'
        LD      (7392h),A
        ; --- START PROC L3062 ---
L3062:  LD      HL,0000h
L3065:  CALL    L3DF9
        LD      A,H
        CP      03h
        JR      NZ,L3065
        CALL    L30F6
        CALL    L31E0
        CALL    L32A3
        CALL    L3328
        LD      DE,30D9h
        LD      HL,0019h
        CALL    L3E7F
        LD      HL,003Ah
        CALL    L3E7F
        LD      HL,02B9h
        CALL    L3E7F
        LD      A,01h
        LD      (7338h),A
        CALL    L3D60
        CALL    L30EA
        ; --- START PROC L3099 ---
L3099:  LD      B,06h
L309B:  CALL    L30A1
        DJNZ    L309B
        RET

        ; --- START PROC L30A1 ---
L30A1:  LD      HL,01F7h
        LD      DE,0040h
        LD      A,B
        DEC     A
L30A9:  ADD     HL,DE
        SUB     03h
        JR      NC,L30A9
L30AE:  INC     L
        INC     L
        INC     A
        JR      NZ,L30AE
        LD      A,(7391h)
        CP      B
        JR      NC,L30C8
        ; --- START PROC L30B9 ---
L30B9:  LD      A,20h           ; ' '
        CALL    L30C2
        LD      DE,001Eh
        ADD     HL,DE
        ; --- START PROC L30C2 ---
L30C2:  CALL    L3DFB
        JP      L3DFB

        ; --- START PROC L30C8 ---
L30C8:  LD      A,0ACh
        ; --- START PROC L30CA ---
L30CA:  CALL    L30D1
        LD      DE,001Eh
        ADD     HL,DE
        ; --- START PROC L30D1 ---
L30D1:  CALL    L30D4
        ; --- START PROC L30D4 ---
L30D4:  CALL    L3DFB
        INC     A
        RET

L30D9:  DB      48h             ; 'H'
        DB      49h             ; 'I'
        DB      47h             ; 'G'
        DB      48h             ; 'H'
        DB      00h
        DB      "SCORE"
        DB      00h
        DB      "ROUND"
        DB      00h

        ; --- START PROC L30EA ---
L30EA:  LD      HL,02DDh
        LD      DE,7398h
        LD      BC,0100h
        JP      L3DD1

        ; --- START PROC L30F6 ---
L30F6:  LD      DE,313Ah
        LD      HL,0001h
L30FC:  LD      A,(DE)
        RLCA
        RLCA
        RLCA
        AND     07h
        INC     A
        LD      B,A
        LD      A,(DE)
        AND     1Fh
        INC     A
        CP      1Fh
        RET     Z
        JR      NC,L3135
        ADD     A,0CFh
        LD      C,A
L3110:  LD      A,C
        CALL    L3DFB
        PUSH    HL
        LD      A,L
        XOR     1Fh
        SUB     05h
        LD      L,A
        LD      A,C
        XOR     01h
        CALL    L3DFB
        POP     HL
        DJNZ    L3110
L3124:  LD      A,L
        AND     1Fh
        CP      0Dh
        JR      NZ,L3132
        LD      A,14h
        ADD     A,L
        LD      L,A
        JR      NC,L3132
        INC     H
L3132:  INC     DE
        JR      L30FC

L3135:  LD      A,B
        ADD     A,L
        LD      L,A
        JR      L3124

L313A:  DB      07h
        DB      0EAh
        DB      4Ah             ; 'J'
        DB      0Dh
        DB      00h
        DB      0E8h
        DB      28h             ; '('
        DB      0Dh
        DB      0Ch
        DB      07h
        DB      3Fh             ; '?'
        DB      06h
        DB      07h
        DB      6Ah             ; 'j'
        DB      1Fh
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0BFh
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0BFh
        DB      0Dh
        DB      0Ch
        DB      05h
        DB      3Fh             ; '?'
        DB      04h
        DB      05h
        DB      88h
        DB      0Dh
        DB      0Ch
        DB      07h
        DB      3Fh             ; '?'
        DB      2Ah             ; '*'
        DB      06h
        DB      07h
        DB      2Ah             ; '*'
        DB      14h
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      7Fh
        DB      0Ch
        DB      0Dh
        DB      5Fh             ; '_'
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      7Fh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      16h
        DB      0Dh
        DB      0Ch
        DB      05h
        DB      08h
        DB      01h
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0Dh
        DB      5Fh             ; '_'
        DB      03h
        DB      02h
        DB      0Bh
        DB      06h
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0Dh
        DB      5Fh             ; '_'
        DB      0FFh
        DB      05h
        DB      48h             ; 'H'
        DB      0FFh
        DB      07h
        DB      2Ah             ; '*'
        DB      06h
        DB      01h
        DB      00h
        DB      08h
        DB      04h
        DB      05h
        DB      28h             ; '('
        DB      04h
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0Dh
        DB      0Ch
        DB      07h
        DB      3Fh             ; '?'
        DB      06h
        DB      07h
        DB      0Ah
        DB      03h
        DB      2Ah             ; '*'
        DB      0Ch
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0BFh
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0BFh
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      00h
        DB      08h
        DB      04h
        DB      0Dh
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      0Dh
        DB      3Fh             ; '?'
        DB      0Ch
        DB      07h
        DB      1Fh
        DB      0Dh
        DB      0Ch
        DB      05h
        DB      3Fh             ; '?'
        DB      04h
        DB      05h
        DB      3Fh             ; '?'
        DB      04h
        DB      0Dh
        DB      1Fh
        DB      0Dh
        DB      0Ch
        DB      07h
        DB      2Ah             ; '*'
        DB      06h
        DB      07h
        DB      4Ah             ; 'J'
        DB      03h
        DB      1Fh
        DB      0Dh
        DB      0Ch
        DB      0FFh
        DB      3Fh             ; '?'
        DB      0Dh
        DB      0Ch
        DB      0FFh
        DB      3Fh             ; '?'
        DB      05h
        DB      0E8h
        DB      48h             ; 'H'
        DB      1Eh

        ; --- START PROC L31E0 ---
L31E0:  LD      B,21h           ; '!'
L31E2:  CALL    L31EA
        DEC     B
        JP      P,L31E2
        RET

        ; --- START PROC L31EA ---
L31EA:  CALL    L3231
        AND     (HL)
        JR      Z,L320A
        CALL    L3248
        ADD     A,0E0h
        BIT     0,A
        JP      Z,L30C2
        ; --- START PROC L31FA ---
L31FA:  CALL    L3DFB
        LD      DE,001Fh
        ADD     HL,DE
        JP      L3DFB

        ; Entry Point
        ; --- START PROC L3204 ---
L3204:  CALL    L3231
        CPL
        AND     (HL)
        LD      (HL),A
        ; --- START PROC L320A ---
L320A:  CALL    L3248
        BIT     0,A
        LD      A,20h           ; ' '
        JP      Z,L30C2
        JR      L31FA

        ; Entry Point
        ; --- START PROC L3216 ---
L3216:  CALL    L3231
        CPL
        AND     (HL)
        LD      (HL),A
        CALL    L3248
        ADD     A,A
        ADD     A,0C8h
        BIT     1,A
        JP      Z,L30D1
        CALL    L30D4
        LD      DE,001Fh
        ADD     HL,DE
        JP      L30D4

        ; --- START PROC L3231 ---
L3231:  LD      HL,7380h
        ; --- START PROC L3234 ---
L3234:  LD      A,B
        AND     0F8h
        RRCA
        RRCA
        RRCA
        ADD     A,L
        LD      L,A
        LD      A,B
        AND     07h
        LD      C,A
        LD      A,01h
        RET     Z
L3243:  ADD     A,A
        DEC     C
        JR      NZ,L3243
        RET

        ; --- START PROC L3248 ---
L3248:  LD      HL,325Fh
        ; --- START PROC L324B ---
L324B:  LD      A,B
        ADD     A,A
        ADD     A,L
        LD      L,A
        JR      NC,L3252
        INC     H
L3252:  LD      E,(HL)
        INC     HL
        LD      A,(HL)
        AND     03h
        LD      D,A
        LD      A,(HL)
        SRL     A
        SRL     A
        EX      DE,HL
        RET

L325F:  DB      44h             ; 'D'
        DB      08h
        DB      4Ch             ; 'L'
        DB      08h
        DB      54h             ; 'T'
        DB      08h
        DB      0A4h
        DB      00h
        DB      67h             ; 'g'
        DB      0Ch
        DB      72h             ; 'r'
        DB      04h
        DB      0B4h
        DB      00h
        DB      0C4h
        DB      08h
        DB      0D4h
        DB      08h
        DB      61h             ; 'a'
        DB      0Dh
        DB      64h             ; 'd'
        DB      05h
        DB      65h             ; 'e'
        DB      0Dh
        DB      68h             ; 'h'
        DB      05h
        DB      71h             ; 'q'
        DB      0Dh
        DB      74h             ; 't'
        DB      05h
        DB      75h             ; 'u'
        DB      0Dh
        DB      78h             ; 'x'
        DB      05h
        DB      0C4h
        DB      09h
        DB      0E7h
        DB      0Dh
        DB      0ECh
        DB      05h
        DB      0EDh
        DB      0Dh
        DB      0F2h
        DB      05h
        DB      0D4h
        DB      09h
        DB      64h             ; 'd'
        DB      02h
        DB      68h             ; 'h'
        DB      02h
        DB      4Ch             ; 'L'
        DB      0Ah
        DB      70h             ; 'p'
        DB      02h
        DB      74h             ; 't'
        DB      02h
        DB      0A3h
        DB      0Eh
        DB      0A6h
        DB      06h
        DB      0A7h
        DB      0Eh
        DB      0B2h
        DB      06h
        DB      0B3h
        DB      0Eh
        DB      0B6h
        DB      06h

        ; --- START PROC L32A3 ---
L32A3:  LD      B,0Dh
L32A5:  CALL    L32AD
        DEC     B
        JP      P,L32A5
        RET

        ; --- START PROC L32AD ---
L32AD:  CALL    L32D9
        AND     (HL)
        JR      Z,L32D2
        CALL    L32DF
        LD      C,20h           ; ' '
        ; --- START PROC L32B8 ---
L32B8:  CALL    L32C2
        LD      A,1Eh
        ADD     A,L
        LD      L,A
        JR      NC,L32C2
        INC     H
        ; --- START PROC L32C2 ---
L32C2:  CALL    L32C5
        ; --- START PROC L32C5 ---
L32C5:  LD      A,(DE)
        ADD     A,C
        CALL    L3DFB
        INC     DE
        RET

        ; Entry Point
        ; --- START PROC L32CC ---
L32CC:  CALL    L32D9
        CPL
        AND     (HL)
        LD      (HL),A
        ; --- START PROC L32D2 ---
L32D2:  CALL    L32DF
        LD      C,00h
        JR      L32B8

        ; --- START PROC L32D9 ---
L32D9:  LD      HL,7386h
        JP      L3234

        ; --- START PROC L32DF ---
L32DF:  LD      HL,330Ch
        CALL    L324B
        ADD     A,A
        ADD     A,A
        LD      DE,32F0h
        ADD     A,E
        LD      E,A
        JR      NC,L32EF
        INC     D
        ; --- START PROC L32EF ---
L32EF:  RET

L32F0:  DB      0D0h
        DB      0D9h
        DB      0DEh
        DB      0D7h
        DB      0D8h
        DB      0D1h
        DB      0D6h
        DB      0DFh
        DB      0D4h
        DB      0D5h
        DB      0DAh
        DB      0DBh
        DB      0DCh
        DB      0D5h
        DB      0D2h
        DB      0DBh
        DB      0D4h
        DB      0DDh
        DB      0DAh
        DB      0D3h
        DB      0DCh
        DB      0D5h
        DB      0DEh
        DB      0D7h
        DB      0D4h
        DB      0DDh
        DB      0D6h
        DB      0DFh
        DB      22h             ; '"'
        DB      00h
        DB      36h             ; '6'
        DB      04h
        DB      0A6h
        DB      08h
        DB      0B2h
        DB      08h
        DB      22h             ; '"'
        DB      0Dh
        DB      36h             ; '6'
        DB      11h
        DB      0A2h
        DB      01h
        DB      0A8h
        DB      11h
        DB      0B0h
        DB      0Dh
        DB      0B6h
        DB      05h
        DB      62h             ; 'b'
        DB      16h
        DB      6Ah             ; 'j'
        DB      12h
        DB      6Eh             ; 'n'
        DB      0Eh
        DB      76h             ; 'v'
        DB      1Ah

        ; --- START PROC L3328 ---
L3328:  LD      B,1Ch
L332A:  CALL    L3332
        DEC     B
        JP      P,L332A
        RET

        ; --- START PROC L3332 ---
L3332:  CALL    L3356
        AND     (HL)
        JR      Z,L3350
        CALL    L335C
        LD      A,(7394h)
        LD      DE,339Ch
        ADD     A,E
        LD      E,A
        JR      NC,L3346
        INC     D
L3346:  LD      A,(DE)
        JP      L30CA

        ; Entry Point
        ; --- START PROC L334A ---
L334A:  CALL    L3356
        CPL
        AND     (HL)
        LD      (HL),A
        ; --- START PROC L3350 ---
L3350:  CALL    L335C
        JP      L30B9

        ; --- START PROC L3356 ---
L3356:  LD      HL,7388h
        JP      L3234

        ; --- START PROC L335C ---
L335C:  LD      HL,3362h
        JP      L324B

L3362:  DB      68h             ; 'h'
        DB      00h
        DB      6Ah             ; 'j'
        DB      00h
        DB      6Ch             ; 'l'
        DB      00h
        DB      6Eh             ; 'n'
        DB      00h
        DB      70h             ; 'p'
        DB      00h
        DB      0E4h
        DB      00h
        DB      0E6h
        DB      00h
        DB      0F2h
        DB      00h
        DB      0F4h
        DB      00h
        DB      26h             ; '&'
        DB      01h
        DB      32h             ; '2'
        DB      01h
        DB      62h             ; 'b'
        DB      01h
        DB      66h             ; 'f'
        DB      01h
        DB      72h             ; 'r'
        DB      01h
        DB      76h             ; 'v'
        DB      01h
        DB      0E4h
        DB      01h
        DB      0EAh
        DB      01h
        DB      0EEh
        DB      01h
        DB      0F4h
        DB      01h
        DB      24h             ; '$'
        DB      02h
        DB      28h             ; '('
        DB      02h
        DB      30h             ; '0'
        DB      02h
        DB      34h             ; '4'
        DB      02h
        DB      6Ch             ; 'l'
        DB      02h
        DB      0A8h
        DB      02h
        DB      0AAh
        DB      02h
        DB      0ACh
        DB      02h
        DB      0AEh
        DB      02h
        DB      0B0h
        DB      02h
        DB      90h
        DB      0A8h
        DB      0A0h
        DB      9Ch
        DB      94h
        DB      0A4h
        DB      98h
        DB      8Ch
        DB      0CDh
        DB      0B0h
        DB      33h             ; '3'
        DB      2Fh             ; '/'
        DB      0A6h
        DB      77h             ; 'w'

        ; --- START PROC L33AA ---
L33AA:  CALL    L33B6
        JP      L30B9

        ; --- START PROC L33B0 ---
L33B0:  LD      HL,738Dh
        JP      L3234

        ; --- START PROC L33B6 ---
L33B6:  LD      HL,33F1h
        JP      L324B

        ; --- START PROC L33BC ---
L33BC:  LD      A,(733Bh)
        AND     A
        RET     M
        LD      A,(7331h)
        AND     07h
        SUB     02h
        RET     C
        LD      B,A
        CALL    L33B0
        AND     (HL)
        JP      Z,L33AA
        CALL    L33B6
        LD      A,(733Bh)
        DEC     A
        JR      NZ,L33DD
        LD      A,(7331h)
L33DD:  AND     18h
        RRCA
        ADD     A,0B0h
        LD      C,A
        LD      A,B
        CP      02h
        LD      A,C
        JP      C,L30CA
        ADD     A,10h
        AND     0F7h
        JP      L30CA

L33F1:  DB      0E8h
        DB      01h
        DB      0F0h
        DB      01h
        DB      64h             ; 'd'
        DB      00h
        DB      74h             ; 't'
        DB      00h
        DB      0A4h
        DB      02h
        DB      0B4h
        DB      02h

        ; Entry Point
        ; --- START PROC L33FD ---
L33FD:  LD      HL,3962h
        LD      (7460h),HL
        LD      HL,3965h
        LD      (7470h),HL
        LD      HL,3969h
        LD      (7480h),HL
        LD      HL,396Dh
        LD      (7490h),HL
        CALL    L2DA1
        NOP
        NOP
        LD      E,(HL)
        INC     (HL)
        AND     H
        LD      BC,3453h
        JP      NZ,4701h
        INC     (HL)
        CALL    C,4C05h
        INC     (HL)
        JP      M,6C05h
        INC     (HL)
        EX      AF,AF'
        RLCA
        LD      E,B
        INC     (HL)
        LD      H,07h
        LD      B,A
        INC     (HL)
        CP      B
        DEC     BC
        LD      E,B
        INC     (HL)
        SUB     0Bh
        LD      L,H
        INC     (HL)
        CALL    PO,580Ch
        INC     (HL)
        LD      (BC),A
        DEC     C
        LD      B,A
        INC     (HL)
        RST     38h

L3445:  DB      0FFh
        DB      0C9h
        DB      0AFh
        DB      32h             ; '2'
        DB      39h             ; '9'
        DB      73h             ; 's'
        DB      0C9h
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      96h
        DB      74h             ; 't'
        DB      18h
        DB      05h
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      86h
        DB      74h             ; 't'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      39h             ; '9'
        DB      73h             ; 's'
        DB      0C9h
        DB      0AFh
        DB      32h             ; '2'
        DB      96h
        DB      74h             ; 't'
        DB      32h             ; '2'
        DB      86h
        DB      "t<2vt2ft>"
        DB      02h
        DB      32h             ; '2'
        DB      39h             ; '9'
        DB      73h             ; 's'
        DB      0C9h
        DB      2Ah             ; '*'
        DB      46h             ; 'F'
        DB      73h             ; 's'
        DB      0CDh
        DB      7Ch             ; '|'
        DB      2Dh             ; '-'
        DB      0DDh
        DB      6Eh             ; 'n'
        DB      02h
        DB      0DDh
        DB      66h             ; 'f'
        DB      03h
        DB      01h
        DB      3Ch             ; '<'
        DB      00h
        DB      0A7h
        DB      0EDh
        DB      42h             ; 'B'
        DB      3Eh             ; '>'
        DB      02h
        DB      30h             ; '0'
        DB      01h
        DB      3Dh             ; '='
        DB      32h             ; '2'
        DB      56h             ; 'V'
        DB      74h             ; 't'
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      0AFh
        DB      32h             ; '2'
        DB      56h             ; 'V'
        DB      74h             ; 't'
        DB      0CDh
        DB      71h             ; 'q'
        DB      2Dh             ; '-'
        DB      0C9h
        DB      0CDh
        DB      0EAh
        DB      34h             ; '4'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      0Bh
        DB      76h             ; 'v'
        DB      21h             ; '!'
        DB      78h             ; 'x'
        DB      00h
        DB      0CDh
        DB      7Ch             ; '|'
        DB      2Dh             ; '-'
        DB      0CDh
        DB      0Fh
        DB      35h             ; '5'
        DB      0CDh
        DB      07h
        DB      35h             ; '5'
        DB      0CDh
        DB      0D5h
        DB      34h             ; '4'
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      21h             ; '!'
        DB      0E0h
        DB      01h
        DB      0CDh
        DB      7Ch             ; '|'
        DB      2Dh             ; '-'
        DB      0CDh
        DB      07h
        DB      35h             ; '5'
        DB      0CDh
        DB      0D5h
        DB      34h             ; '4'
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      0AFh
        DB      32h             ; '2'
        DB      0Bh
        DB      76h             ; 'v'
        DB      0CDh
        DB      0D1h
        DB      34h             ; '4'
        DB      0CDh
        DB      29h             ; ')'
        DB      35h             ; '5'
        DB      0CDh
        DB      24h             ; '$'
        DB      35h             ; '5'
        DB      0CDh
        DB      71h             ; 'q'
        DB      2Dh             ; '-'
        DB      0C9h
        DB      3Eh             ; '>'
        DB      0DCh
        DB      18h
        DB      0Fh
        DB      3Ah             ; ':'
        DB      31h             ; '1'
        DB      73h             ; 's'
        DB      0E6h
        DB      07h
        DB      3Dh             ; '='
        DB      0C0h
        DB      3Ah             ; ':'
        DB      31h             ; '1'
        DB      73h             ; 's'
        DB      0E6h
        DB      08h
        DB      0Fh
        DB      0C6h
        DB      0E8h
        DB      21h             ; '!'
        DB      0ACh
        DB      01h
        DB      0C3h
        DB      0CAh
        DB      30h             ; '0'
        DB      0CDh
        DB      0A6h
        DB      20h             ; ' '
        DB      0E6h
        DB      07h
        DB      32h             ; '2'
        DB      72h             ; 'r'
        DB      73h             ; 's'
        DB      0CDh
        DB      0A6h
        DB      20h             ; ' '
        DB      0E6h
        DB      07h
        DB      32h             ; '2'
        DB      76h             ; 'v'
        DB      73h             ; 's'
        DB      21h             ; '!'
        DB      10h
        DB      10h
        DB      22h             ; '"'
        DB      70h             ; 'p'
        DB      73h             ; 's'
        DB      21h             ; '!'
        DB      15h
        DB      15h
        DB      22h             ; '"'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      0C9h
        DB      21h             ; '!'
        DB      74h             ; 't'
        DB      73h             ; 's'
        DB      11h
        DB      0AEh
        DB      01h
        DB      18h
        DB      06h
        DB      21h             ; '!'
        DB      70h             ; 'p'
        DB      73h             ; 's'
        DB      11h
        DB      0AAh
        DB      01h
        DB      7Eh             ; '~'
        DB      2Ch             ; ','
        DB      35h             ; '5'
        DB      0C0h
        DB      77h             ; 'w'
        DB      2Ch             ; ','
        DB      7Eh             ; '~'
        DB      3Ch             ; '<'
        DB      0E6h
        DB      07h
        DB      77h             ; 'w'
        DB      0EBh
        DB      0C3h
        DB      3Eh             ; '>'
        DB      33h             ; '3'
        DB      21h             ; '!'
        DB      0AEh
        DB      01h
        DB      18h
        DB      03h
        DB      21h             ; '!'
        DB      0AAh
        DB      01h
        DB      0CDh
        DB      0F9h
        DB      3Dh             ; '='
        DB      0CDh
        DB      0FBh
        DB      3Dh             ; '='
        DB      11h
        DB      1Eh
        DB      00h
        DB      19h
        DB      3Eh             ; '>'
        DB      0DAh
        DB      0CDh
        DB      0FBh
        DB      3Dh             ; '='
        DB      0C3h
        DB      0FBh
        DB      3Dh             ; '='
        DB      0CDh
        DB      0A2h
        DB      35h             ; '5'
        DB      0CDh
        DB      71h             ; 'q'
        DB      2Dh             ; '-'
        DB      0CDh
        DB      0B7h
        DB      35h             ; '5'
        DB      0CDh
        DB      0F9h
        DB      35h             ; '5'
        DB      21h             ; '!'
        DB      87h
        DB      36h             ; '6'

        ; --- START PROC L354D ---
L354D:  LD      (737Ch),HL
        LD      HL,(744Ah)
        LD      A,(744Ch)
        ADD     A,L
        LD      (744Ch),A
        LD      A,(744Dh)
        ADC     A,H
        RET     Z
        LD      (744Dh),A
L3562:  CALL    L356F
        CALL    L3573
        LD      HL,744Dh
        DEC     (HL)
        JR      NZ,L3562
        RET

        ; --- START PROC L356F ---
L356F:  LD      HL,(737Ch)
        JP      (HL)

        ; --- START PROC L3573 ---
L3573:  LD      A,(7449h)
        AND     A
        RET     M
        JR      Z,L3584
        CP      02h
        JR      C,L3591
        JR      Z,L3595
        INC     (IY+00h)
        RET

L3584:  LD      A,(IY+01h)
        INC     A
        CP      0C0h
        JR      C,L358D
        XOR     A
L358D:  LD      (IY+01h),A
        RET

L3591:  DEC     (IY+00h)
        RET

L3595:  LD      A,(IY+01h)
        SUB     01h
        JR      NC,L359E
        LD      A,0BFh
L359E:  LD      (IY+01h),A
        RET

L35A2:  DB      21h             ; '!'
        DB      58h             ; 'X'
        DB      60h             ; '`'
        DB      22h             ; '"'
        DB      00h
        DB      7Fh
        DB      0AFh
        DB      "2Ftog"
        DB      22h             ; '"'
        DB      4Ch             ; 'L'
        DB      74h             ; 't'
        DB      21h             ; '!'
        DB      02h
        DB      02h
        DB      22h             ; '"'
        DB      "Ht:Ft=>"
        DB      0Ah
        DB      20h             ; ' '
        DB      09h
        DB      2Ah             ; '*'
        DB      31h             ; '1'
        DB      73h             ; 's'
        DB      0CBh
        DB      5Eh             ; '^'
        DB      28h             ; '('
        DB      02h
        DB      3Eh             ; '>'
        DB      0Fh
        DB      32h             ; '2'
        DB      03h
        DB      7Fh
        DB      3Ah             ; ':'
        DB      31h             ; '1'
        DB      73h             ; 's'
        DB      0E6h
        DB      07h
        DB      21h             ; '!'
        DB      0F1h
        DB      35h             ; '5'
        DB      85h
        DB      6Fh             ; 'o'
        DB      30h             ; '0'
        DB      01h
        DB      24h             ; '$'
        DB      3Ah             ; ':'
        DB      46h             ; 'F'
        DB      74h             ; 't'
        DB      0A7h
        DB      7Eh             ; '~'
        DB      28h             ; '('
        DB      01h
        DB      3Ch             ; '<'
        DB      0FEh
        DB      10h
        DB      30h             ; '0'
        DB      07h
        DB      87h
        DB      87h
        DB      4Fh             ; 'O'
        DB      3Ah             ; ':'
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      81h
        DB      87h
        DB      87h
        DB      32h             ; '2'
        DB      02h
        DB      7Fh
        DB      0C9h
        DB      02h
        DB      02h
        DB      00h
        DB      00h
        DB      00h
        DB      02h
        DB      10h
        DB      10h
        DB      3Ah             ; ':'
        DB      46h             ; 'F'
        DB      74h             ; 't'
        DB      0A7h
        DB      28h             ; '('
        DB      10h
        DB      3Ah             ; ':'
        DB      3Ch             ; '<'
        DB      73h             ; 's'
        DB      0A7h
        DB      21h             ; '!'
        DB      80h
        DB      01h
        DB      28h             ; '('
        DB      03h
        DB      21h             ; '!'
        DB      00h
        DB      02h
        DB      22h             ; '"'
        DB      4Ah             ; 'J'
        DB      74h             ; 't'
        DB      0C9h
        DB      21h             ; '!'
        DB      44h             ; 'D'
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      92h
        DB      73h             ; 's'
        DB      0BDh
        DB      30h             ; '0'
        DB      11h
        DB      0BCh
        DB      30h             ; '0'
        DB      07h
        DB      2Ah             ; '*'
        DB      56h             ; 'V'
        DB      73h             ; 's'
        DB      22h             ; '"'
        DB      4Ah             ; 'J'
        DB      74h             ; 't'
        DB      0C9h
        DB      2Ah             ; '*'
        DB      54h             ; 'T'
        DB      73h             ; 's'
        DB      22h             ; '"'
        DB      4Ah             ; 'J'
        DB      74h             ; 't'
        DB      0C9h
        DB      2Ah             ; '*'
        DB      50h             ; 'P'
        DB      73h             ; 's'
        DB      22h             ; '"'
        DB      4Ah             ; 'J'
        DB      74h             ; 't'
        DB      0C9h
        DB      0CDh
        DB      66h             ; 'f'
        DB      36h             ; '6'
        DB      3Ch             ; '<'
        DB      32h             ; '2'
        DB      03h
        DB      76h             ; 'v'
        DB      21h             ; '!'
        DB      78h             ; 'x'
        DB      00h
        DB      0CDh
        DB      "|-:Bt"
        DB      0E6h
        DB      0F8h
        DB      0Fh
        DB      0Fh
        DB      0Fh
        DB      21h             ; '!'
        DB      78h             ; 'x'
        DB      36h             ; '6'
        DB      85h
        DB      6Fh             ; 'o'
        DB      30h             ; '0'
        DB      01h
        DB      24h             ; '$'
        DB      6Eh             ; 'n'
        DB      26h             ; '&'
        DB      0Ah
        DB      22h             ; '"'
        DB      02h
        DB      7Fh
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      21h             ; '!'
        DB      0F0h
        DB      00h
        DB      22h             ; '"'
        DB      00h
        DB      7Fh
        DB      21h             ; '!'
        DB      0ABh
        DB      2Eh             ; '.'
        DB      22h             ; '"'
        DB      00h
        DB      74h             ; 't'
        DB      0CDh
        DB      71h             ; 'q'
        DB      2Dh             ; '-'
        DB      0C9h

        ; --- START PROC L3666 ---
L3666:  XOR     A
        LD      (760Bh),A
        XOR     A
        LD      (760Ch),A
        LD      (760Dh),A
        LD      (760Eh),A
        LD      (760Fh),A
        RET

L3678:  DB      0DCh
        DB      0DCh
        DB      0DCh
        DB      0DCh
        DB      0DCh
        DB      0DCh
        DB      0DCh
        DB      0D8h
        DB      0D4h
        DB      0D0h
        DB      0CCh
        DB      0C8h
        DB      04h
        DB      24h             ; '$'
        DB      40h             ; '@'
        DB      0CDh
        DB      0D0h
        DB      "8*Ht}"
        DB      0EEh
        DB      02h
        DB      0BCh
        DB      28h             ; '('
        DB      3Bh             ; ';'
        DB      0FDh
        DB      7Eh             ; '~'
        DB      01h
        DB      0E6h
        DB      0Fh
        DB      0C0h
        DB      0FDh
        DB      7Eh             ; '~'
        DB      00h
        DB      0D6h
        DB      08h
        DB      0E6h
        DB      0Fh
        DB      0C0h
        DB      0AFh
        DB      32h             ; '2'
        DB      0Bh
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      46h             ; 'F'
        DB      74h             ; 't'
        DB      0A7h
        DB      28h             ; '('
        DB      06h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      22h             ; '"'
        DB      08h
        DB      73h             ; 's'
        DB      0CDh
        DB      0F0h
        DB      36h             ; '6'
        DB      3Eh             ; '>'
        DB      3Ch             ; '<'
        DB      32h             ; '2'
        DB      0Bh
        DB      73h             ; 's'
        DB      21h             ; '!'
        DB      0C5h
        DB      3Ah             ; ':'
        DB      22h             ; '"'
        DB      08h
        DB      73h             ; 's'
        DB      0CDh
        DB      84h
        DB      "7*Ht}"
        DB      0BCh
        DB      28h             ; '('
        DB      11h
        DB      0CDh
        DB      0E7h
        DB      36h             ; '6'
        DB      38h             ; '8'
        DB      07h
        DB      ":Ht2It"
        DB      0C9h
        DB      3Ah             ; ':'
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      0A7h
        DB      0F8h
        DB      0CDh
        DB      0E7h
        DB      36h             ; '6'
        DB      0D0h
        DB      3Ah             ; ':'
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      0F6h
        DB      80h
        DB      32h             ; '2'
        DB      49h             ; 'I'
        DB      74h             ; 't'
        DB      0C9h

        ; --- START PROC L36E7 ---
L36E7:  LD      B,A
        INC     B
        LD      A,(7379h)
L36EC:  RRCA
        DJNZ    L36EC
        RET

        ; --- START PROC L36F0 ---
L36F0:  LD      HL,0F08h
        CALL    L3744
        LD      HL,1008h
        CALL    L3739
        LD      HL,0800h
        CALL    L3744
        LD      HL,08FFh
        CALL    L3739
        LD      HL,0008h
        CALL    L3744
        LD      HL,0FF08h
        CALL    L3739
        LD      HL,080Fh
        CALL    L3744
        LD      HL,0810h
        CALL    L3739
        LD      A,(IY+00h)
        CP      78h             ; 'x'
        RET     NZ
        LD      A,(IY+01h)
        CP      50h             ; 'P'
        JR      Z,L3730
        CP      70h             ; 'p'
        RET     NZ
L3730:  LD      A,(7379h)
        OR      02h
        LD      (7379h),A
        RET

        ; --- START PROC L3739 ---
L3739:  CALL    NC,L3744
        LD      A,(7379h)
        RLA
        LD      (7379h),A
        RET

        ; --- START PROC L3744 ---
L3744:  CALL    L375B
        ADD     A,30h           ; '0'
        RET     NC
        AND     1Fh
        RRA
        LD      L,A
        LD      H,73h           ; 's'
        LD      A,(HL)
        JR      C,L3757
L3753:  RLCA
        DJNZ    L3753
        RET

L3757:  RRCA
        DJNZ    L3757
        RET

        ; --- START PROC L375B ---
L375B:  LD      B,00h
        LD      A,(IY+01h)
        ADD     A,L
        CP      08h
        JR      NC,L3767
        ADD     A,0C0h
L3767:  LD      L,A
        LD      A,(IY+00h)
        ADD     A,H
        RRA
        RRA
        RRA
        RL      B
        RRA
        RR      L
        RRA
        RR      L
        RRA
        RR      L
        RL      B
        INC     B
        AND     03h
        ADD     A,7Ch           ; '|'
        LD      H,A
        LD      A,(HL)
        RET

L3784:  DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      0CDh
        DB      5Bh             ; '['
        DB      37h             ; '7'
        DB      0FEh
        DB      0F0h
        DB      0D2h
        DB      0A2h
        DB      37h             ; '7'
        DB      0FEh
        DB      0E8h
        DB      0D2h
        DB      0B9h
        DB      37h             ; '7'
        DB      0FEh
        DB      0C8h
        DB      0D0h
        DB      0FEh
        DB      0B0h
        DB      0D2h
        DB      20h             ; ' '
        DB      38h             ; '8'
        DB      0FEh
        DB      8Ch
        DB      0D2h
        DB      8Dh
        DB      38h             ; '8'
        DB      0C9h
        DB      11h
        DB      0Ch
        DB      33h             ; '3'
        DB      0CDh
        DB      0Ah
        DB      39h             ; '9'
        DB      0CDh
        DB      0CCh
        DB      32h             ; '2'
        DB      0CDh
        DB      1Ch
        DB      39h             ; '9'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      08h
        DB      76h             ; 'v'
        DB      11h
        DB      50h             ; 'P'
        DB      00h
        DB      0C3h
        DB      3Bh             ; ';'
        DB      3Dh             ; '='
        DB      0CDh
        DB      66h             ; 'f'
        DB      36h             ; '6'
        DB      0CDh
        DB      0D1h
        DB      34h             ; '4'
        DB      21h             ; '!'
        DB      7Bh             ; '{'
        DB      2Dh             ; '-'
        DB      22h             ; '"'
        DB      18h
        DB      74h             ; 't'
        DB      0CDh
        DB      0D8h
        DB      2Ch             ; ','
        DB      21h             ; '!'
        DB      80h
        DB      7Fh
        DB      11h
        DB      00h
        DB      7Fh
        DB      01h
        DB      80h
        DB      00h
        DB      0EDh
        DB      0B0h
        DB      3Ah             ; ':'
        DB      96h
        DB      73h             ; 's'
        DB      0E6h
        DB      0FCh
        DB      0C6h
        DB      0B0h
        DB      6Fh             ; 'o'
        DB      0Eh
        DB      "<:rsG:vs"
        DB      0B8h
        DB      20h             ; ' '
        DB      11h
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      0Ah
        DB      76h             ; 'v'
        DB      0Eh
        DB      78h             ; 'x'
        DB      2Eh             ; '.'
        DB      0C0h
        DB      3Ah             ; ':'
        DB      94h
        DB      73h             ; 's'
        DB      0B8h
        DB      20h             ; ' '
        DB      02h
        DB      2Eh             ; '.'
        DB      0C4h
        DB      26h             ; '&'
        DB      0Fh
        DB      22h             ; '"'
        DB      02h
        DB      7Fh
        DB      7Dh             ; '}'
        DB      0D6h
        DB      0B0h
        DB      0Fh
        DB      0Fh
        DB      0CDh
        DB      30h             ; '0'
        DB      3Dh             ; '='
        DB      69h             ; 'i'
        DB      26h             ; '&'
        DB      00h
        DB      0CDh
        DB      7Ch             ; '|'
        DB      2Dh             ; '-'
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      0CDh
        DB      29h             ; ')'
        DB      35h             ; '5'
        DB      0CDh
        DB      24h             ; '$'
        DB      35h             ; '5'
        DB      21h             ; '!'
        DB      00h
        DB      75h             ; 'u'
        DB      11h
        DB      00h
        DB      74h             ; 't'
        DB      01h
        DB      00h
        DB      01h
        DB      0EDh
        DB      0B0h
        DB      0C9h
        DB      11h
        DB      0F1h
        DB      33h             ; '3'
        DB      0CDh
        DB      0Ah
        DB      39h             ; '9'
        DB      0CDh
        DB      0A4h
        DB      33h             ; '3'
        DB      0CDh
        DB      39h             ; '9'
        DB      38h             ; '8'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      06h
        DB      76h             ; 'v'
        DB      11h
        DB      00h
        DB      01h
        DB      0CDh
        DB      3Bh             ; ';'
        DB      3Dh             ; '='
        DB      18h
        DB      74h             ; 't'
        DB      78h             ; 'x'
        DB      0FEh
        DB      02h
        DB      30h             ; '0'
        DB      0Ch
        DB      3Eh             ; '>'
        DB      02h
        DB      "2Ft!r4"
        DB      22h             ; '"'
        DB      10h
        DB      74h             ; 't'
        DB      0C9h
        DB      0AFh
        DB      "2:s!it"
        DB      11h
        DB      10h
        DB      00h
        DB      06h
        DB      04h
        DB      7Eh             ; '~'
        DB      0EEh
        DB      02h
        DB      77h             ; 'w'
        DB      19h
        DB      10h
        DB      0F9h
        DB      21h             ; '!'
        DB      13h
        DB      3Ah             ; ':'
        DB      0CDh
        DB      80h
        DB      38h             ; '8'
        DB      2Ah             ; '*'
        DB      48h             ; 'H'
        DB      73h             ; 's'
        DB      0EDh
        DB      5Bh             ; '['
        DB      12h
        DB      74h             ; 't'
        DB      0A7h
        DB      0EDh
        DB      52h             ; 'R'
        DB      19h
        DB      38h             ; '8'
        DB      03h
        DB      22h             ; '"'
        DB      12h
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      62h             ; 'b'
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      72h             ; 'r'
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      82h
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      92h
        DB      74h             ; 't'
        DB      0C9h
        DB      22h             ; '"'
        DB      60h             ; '`'
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      70h             ; 'p'
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      80h
        DB      74h             ; 't'
        DB      22h             ; '"'
        DB      90h
        DB      74h             ; 't'
        DB      0C9h
        DB      11h
        DB      62h             ; 'b'
        DB      33h             ; '3'
        DB      0CDh
        DB      0Ah
        DB      39h             ; '9'
        DB      0CDh
        DB      4Ah             ; 'J'
        DB      33h             ; '3'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      09h
        DB      76h             ; 'v'
        DB      3Ah             ; ':'
        DB      97h
        DB      73h             ; 's'
        DB      87h
        DB      21h             ; '!'
        DB      0BEh
        DB      38h             ; '8'
        DB      85h
        DB      6Fh             ; 'o'
        DB      30h             ; '0'
        DB      01h
        DB      24h             ; '$'
        DB      5Eh             ; '^'
        DB      23h             ; '#'
        DB      56h             ; 'V'
        DB      0CDh
        DB      3Bh             ; ';'
        DB      3Dh             ; '='
        DB      3Ah             ; ':'
        DB      92h
        DB      73h             ; 's'
        DB      3Dh             ; '='
        DB      32h             ; '2'
        DB      92h
        DB      73h             ; 's'
        DB      0FEh
        DB      14h
        DB      0C0h
        DB      21h             ; '!'
        DB      97h
        DB      34h             ; '4'
        DB      22h             ; '"'
        DB      18h
        DB      74h             ; 't'
        DB      0C9h
        DB      10h
        DB      00h
        DB      20h             ; ' '
        DB      00h
        DB      30h             ; '0'
        DB      00h
        DB      40h             ; '@'
        DB      00h
        DB      50h             ; 'P'
        DB      00h
        DB      60h             ; '`'
        DB      00h
        DB      70h             ; 'p'
        DB      00h
        DB      80h
        DB      00h
        DB      00h
        DB      01h
        DB      0FDh
        DB      7Eh             ; '~'
        DB      01h
        DB      0E6h
        DB      07h
        DB      0C0h
        DB      0FDh
        DB      7Eh             ; '~'
        DB      00h
        DB      0E6h
        DB      07h
        DB      0C0h
        DB      21h             ; '!'
        DB      00h
        DB      00h
        DB      0CDh
        DB      5Bh             ; '['
        DB      37h             ; '7'
        DB      0E6h
        DB      0FEh
        DB      0FEh
        DB      0E2h
        DB      28h             ; '('
        DB      0Eh
        DB      23h             ; '#'
        DB      7Eh             ; '~'
        DB      0FEh
        DB      0E1h
        DB      28h             ; '('
        DB      08h
        DB      11h
        DB      1Fh
        DB      00h
        DB      19h
        DB      7Eh             ; '~'
        DB      0FEh
        DB      0E0h
        DB      0C0h
        DB      11h
        DB      5Fh             ; '_'
        DB      32h             ; '2'
        DB      0CDh
        DB      0Ah
        DB      39h             ; '9'
        DB      0CDh
        DB      16h
        DB      32h             ; '2'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      07h
        DB      76h             ; 'v'
        DB      11h
        DB      00h
        DB      02h
        DB      0C3h
        DB      3Bh             ; ';'
        DB      3Dh             ; '='
        DB      06h
        DB      00h
        DB      1Ah
        DB      0BDh
        DB      20h             ; ' '
        DB      07h
        DB      13h
        DB      1Ah
        DB      1Bh
        DB      0ACh
        DB      0E6h
        DB      03h
        DB      0C8h
        DB      13h
        DB      13h
        DB      04h
        DB      18h
        DB      0F0h
        DB      78h             ; 'x'
        DB      87h
        DB      80h
        DB      21h             ; '!'
        DB      38h             ; '8'
        DB      39h             ; '9'
        DB      85h
        DB      6Fh             ; 'o'
        DB      30h             ; '0'
        DB      01h
        DB      24h             ; '$'
        DB      06h
        DB      03h
        DB      7Eh             ; '~'
        DB      23h             ; '#'
        DB      0A7h
        DB      0F8h
        DB      0E5h
        DB      0C5h
        DB      47h             ; 'G'
        DB      0CDh
        DB      04h
        DB      32h             ; '2'
        DB      0C1h
        DB      0E1h
        DB      10h
        DB      0F2h
        DB      0C9h
        DB      00h
        DB      03h
        DB      80h
        DB      02h
        DB      06h
        DB      80h
        DB      01h
        DB      04h
        DB      80h
        DB      05h
        DB      19h
        DB      80h
        DB      07h
        DB      0Bh
        DB      0Ah
        DB      08h
        DB      0Eh
        DB      0Fh
        DB      11h
        DB      17h
        DB      80h
        DB      0Ch
        DB      12h
        DB      13h
        DB      0Dh
        DB      14h
        DB      15h
        DB      16h
        DB      1Bh
        DB      80h
        DB      1Ch
        DB      1Dh
        DB      80h
        DB      09h
        DB      18h
        DB      1Eh
        DB      10h
        DB      1Ah
        DB      1Fh
        DB      21h             ; '!'
        DB      20h             ; ' '
        DB      80h

        ; Entry Point
        ; --- START PROC L3962 ---
L3962:  XOR     A
        JR      L396F

        ; Entry Point
        ; --- START PROC L3965 ---
L3965:  LD      A,01h
        JR      L396F

L3969:  DB      3Eh             ; '>'
        DB      02h
        DB      18h
        DB      02h
        DB      3Eh             ; '>'
        DB      03h

        ; --- START PROC L396F ---
L396F:  CALL    L399A
        CALL    L2D71
        CALL    L39BC
        CALL    L3A5B
        XOR     A
        LD      (760Dh),A
        LD      (760Eh),A
        LD      (760Fh),A
        LD      DE,760Fh
        LD      HL,(7344h)
        LD      A,(7392h)
        CP      L
        JR      NC,L3996
        DEC     DE
        CP      H
        JR      NC,L3996
        DEC     DE
L3996:  LD      A,01h
        LD      (DE),A
        RET

        ; --- START PROC L399A ---
L399A:  LD      HL,7447h
        LD      (HL),A
        ADD     A,A
        ADD     A,(HL)
        LD      HL,3A07h
        ADD     A,L
        LD      L,A
        JR      NC,L39A8
        INC     H
L39A8:  LD      A,(HL)
        INC     HL
        LD      (7449h),A
        LD      A,(HL)
        INC     HL
        LD      (IY+01h),A
        LD      A,(HL)
        LD      (IY+00h),A
        LD      HL,0000h
        LD      (744Ch),HL
        ; --- START PROC L39BC ---
L39BC:  LD      A,(7339h)
        DEC     A
        JR      Z,L39F2
        LD      A,(7449h)
        ADD     A,A
        ADD     A,A
        ADD     A,A
        LD      C,A
        LD      A,(7331h)
        AND     04h
        ADD     A,C
L39CF:  ADD     A,50h           ; 'P'
        LD      C,A
        LD      A,(7456h)
        AND     A
        LD      A,C
        JR      Z,L39DB
        ADD     A,20h           ; ' '
L39DB:  LD      (IY+02h),A
        LD      A,(7447h)
        LD      HL,39EEh
        ADD     A,L
        LD      L,A
        JR      NC,L39E9
        INC     H
L39E9:  LD      A,(HL)
        LD      (IY+03h),A
        RET

L39EE:  DB      06h
        DB      0Dh
        DB      07h
        DB      09h

L39F2:  LD      A,(7331h)
        AND     01h
        LD      C,A
        ADD     A,A
        ADD     A,A
        ADD     A,C
        LD      C,A
        LD      A,(7449h)
        AND     01h
        ADD     A,A
        ADD     A,C
        ADD     A,A
        ADD     A,A
        JR      L39CF

L3A07:  DB      00h
        DB      5Ch             ; '\'
        DB      28h             ; '('
        DB      00h
        DB      53h             ; 'S'
        DB      38h             ; '8'
        DB      02h
        DB      6Ah             ; 'j'
        DB      38h             ; '8'
        DB      02h
        DB      61h             ; 'a'
        DB      48h             ; 'H'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      0Ch
        DB      76h             ; 'v'
        DB      2Ah             ; '*'
        DB      42h             ; 'B'
        DB      74h             ; 't'
        DB      11h
        DB      3Ch             ; '<'
        DB      00h
        DB      0AFh
        DB      0A7h
        DB      0EDh
        DB      52h             ; 'R'
        DB      30h             ; '0'
        DB      01h
        DB      3Ch             ; '<'
        DB      32h             ; '2'
        DB      46h             ; 'F'
        DB      74h             ; 't'
        DB      0CDh
        DB      3Ch             ; '<'
        DB      3Ah             ; ':'
        DB      0CDh
        DB      7Eh             ; '~'
        DB      3Ah             ; ':'
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      0AFh
        DB      32h             ; '2'
        DB      0Ch
        DB      76h             ; 'v'
        DB      21h             ; '!'
        DB      75h             ; 'u'
        DB      39h             ; '9'
        DB      22h             ; '"'
        DB      40h             ; '@'
        DB      74h             ; 't'
        DB      0E9h
        DB      3Ah             ; ':'
        DB      46h             ; 'F'
        DB      74h             ; 't'
        DB      0A7h
        DB      28h             ; '('
        DB      09h
        DB      3Ah             ; ':'
        DB      31h             ; '1'
        DB      73h             ; 's'
        DB      0E6h
        DB      08h
        DB      3Eh             ; '>'
        DB      0Fh
        DB      20h             ; ' '
        DB      02h
        DB      3Eh             ; '>'
        DB      04h
        DB      0FDh
        DB      77h             ; 'w'
        DB      03h
        DB      3Ah             ; ':'
        DB      31h             ; '1'
        DB      73h             ; 's'
        DB      0E6h
        DB      04h
        DB      0C6h
        DB      48h             ; 'H'
        DB      0FDh
        DB      77h             ; 'w'
        DB      02h
        DB      0C9h

        ; --- START PROC L3A5B ---
L3A5B:  CALL    L3C63
        CALL    L3C0D
        LD      A,(7446h)
        AND     A
        JR      Z,L3A90
        LD      A,(7339h)
        CP      01h
        RET     Z
        LD      HL,3B45h
        JR      C,L3A75
        LD      HL,3B29h
L3A75:  LD      (737Ah),HL
        LD      HL,3AA9h
        JP      L354D

L3A7E:  DB      21h             ; '!'
        DB      20h             ; ' '
        DB      3Bh             ; ';'
        DB      22h             ; '"'
        DB      7Ah             ; 'z'
        DB      73h             ; 's'
        DB      0CDh
        DB      83h
        DB      3Ch             ; '<'
        DB      0CDh
        DB      3Ch             ; '<'
        DB      3Ch             ; '<'
        DB      21h             ; '!'
        DB      0A9h
        DB      3Ah             ; ':'
        DB      0C3h
        DB      4Dh             ; 'M'
        DB      35h             ; '5'

L3A90:  LD      HL,3B1Ah
        LD      (737Ah),HL
        LD      HL,0000h
        LD      HL,(7308h)
        LD      HL,3AA9h
        CALL    L354D
        LD      HL,3AC5h
        LD      (7308h),HL
        RET

        ; Entry Point
        ; --- START PROC L3AA9 ---
L3AA9:  LD      A,(IY+01h)
        AND     0Fh
        RET     NZ
        LD      A,(IY+00h)
        SUB     08h
        AND     0Fh
        RET     NZ
        CALL    L36F0
        CALL    L3AEB
        CALL    L3B16
        CALL    L3BD0
        LD      A,(7449h)
        XOR     02h
        LD      C,A
        LD      B,04h
L3ACB:  LD      A,(7448h)
        AND     03h
        CP      C
        JR      Z,L3ADC
        LD      (7449h),A
        PUSH    BC
        CALL    L36E7
        POP     BC
        RET     NC
L3ADC:  LD      A,(7448h)
        RRCA
        RRCA
        LD      (7448h),A
        DJNZ    L3ACB
        LD      A,C
        LD      (7449h),A
        RET

        ; --- START PROC L3AEB ---
L3AEB:  LD      A,(7339h)
        AND     A
        RET     NZ
        LD      HL,7379h
        LD      A,(IY+00h)
        CP      58h             ; 'X'
        JR      NZ,L3B03
        LD      A,(IY+01h)
        CP      60h             ; '`'
        RET     NZ
        SET     3,(HL)
        RET

L3B03:  CP      98h
        RET     NZ
        LD      A,(IY+01h)
        CP      30h             ; '0'
        JR      NZ,L3B10
        SET     2,(HL)
        RET

L3B10:  CP      90h
        RET     NZ
        SET     0,(HL)
        RET

        ; --- START PROC L3B16 ---
L3B16:  LD      HL,(737Ah)
        JP      (HL)

        ; Entry Point
        ; --- START PROC L3B1A ---
L3B1A:  LD      HL,4860h
        LD      C,00h
        RET

        ; Entry Point
        ; --- START PROC L3B20 ---
L3B20:  LD      HL,(7F00h)
        LD      A,L
        LD      L,H
        LD      H,L
        LD      C,04h
        RET

        ; Entry Point
        ; --- START PROC L3B29 ---
L3B29:  LD      C,00h
        LD      A,(7447h)
        ADD     A,A
        LD      HL,3B3Dh
        ADD     A,L
        LD      L,A
        JR      NC,L3B37
        INC     H
L3B37:  LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        JR      L3BA2

L3B3D:  DB      08h
        DB      0B0h
        DB      08h
        DB      10h
        DB      0A8h
        DB      0B0h
        DB      0A8h
        DB      10h
        DB      0Eh
        DB      00h

        ; Entry Point
        ; --- START PROC L3B47 ---
L3B47:  LD      HL,3B58h
        LD      A,(7447h)
        ADD     A,A
        ADD     A,L
        LD      L,A
        JR      NC,L3B53
        INC     H
L3B53:  LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        JP      (HL)

L3B58:  DB      9Fh
        DB      3Bh             ; ';'
        DB      60h             ; '`'
        DB      3Bh             ; ';'
        DB      82h
        DB      3Bh             ; ';'
        DB      93h
        DB      3Bh             ; ';'

        ; Entry Point
        ; --- START PROC L3B60 ---
L3B60:  LD      A,(7459h)
        ADD     A,A
        LD      HL,3B7Ah
        ADD     A,L
        LD      L,A
        JR      NC,L3B6C
        INC     H
L3B6C:  LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      HL,(7F00h)
        LD      A,L
        ADD     A,E
        LD      L,A
        LD      A,H
        ADD     A,D
        LD      H,A
        JR      L3BA2

L3B7A:  DB      00h
        DB      20h             ; ' '
        DB      0E0h
        DB      00h
        DB      00h
        DB      0E0h
        DB      20h             ; ' '
        DB      00h

        ; Entry Point
        ; --- START PROC L3B82 ---
L3B82:  LD      HL,(7F04h)
        LD      A,(7F00h)
        ADD     A,A
        SUB     L
        LD      L,A
        LD      A,(7F01h)
        ADD     A,A
        SUB     H
        LD      H,A
        JR      L3BA2

        ; Entry Point
        ; --- START PROC L3B93 ---
L3B93:  CALL    L3D17
        CP      21h             ; '!'
        JR      NC,L3B9F
        CALL    L209C
        JR      L3BA2

        ; --- START PROC L3B9F ---
L3B9F:  LD      HL,(7F00h)
        ; --- START PROC L3BA2 ---
L3BA2:  LD      A,L
        LD      L,H
        LD      H,A
        CALL    L3BBB
        LD      A,H
        CP      58h             ; 'X'
        RET     NZ
        LD      A,L
        CP      28h             ; '('
        JR      C,L3BB7
        CP      0A0h
        RET     C
        LD      L,00h
        RET

L3BB7:  LD      A,0C0h
        LD      L,A
        RET

        ; --- START PROC L3BBB ---
L3BBB:  LD      A,(IY+00h)
        CP      38h             ; '8'
        RET     NZ
        LD      A,(IY+01h)
        CP      60h             ; '`'
        RET     NZ
        LD      A,(7449h)
        RRCA
        RET     C
        LD      HL,2860h
        RET

        ; --- START PROC L3BD0 ---
L3BD0:  LD      A,H
        SUB     (IY+00h)
        RR      E
        JP      P,L3BDB
        NEG
L3BDB:  LD      D,A
        LD      A,L
        SUB     (IY+01h)
        RR      E
        JP      P,L3BE7
        NEG
L3BE7:  CP      D
        LD      A,00h
        RLA
        RL      E
        JR      NC,L3BF1
        XOR     03h
L3BF1:  RL      E
        JR      NC,L3BF7
        XOR     07h
L3BF7:  XOR     C
        LD      HL,3C05h
        ADD     A,L
        LD      L,A
        JR      NC,L3C00
        INC     H
L3C00:  LD      A,(HL)
        LD      (7448h),A
        RET

        ; Entry Point
        ; --- START PROC L3C05 ---
L3C05:  SBC     A,H
        LD      H,E
        LD      C,E
        LD      E,36h           ; '6'
        RET

        ; Entry Point
        ; --- START PROC L3C0B ---
L3C0B:  POP     HL
        OR      H
        ; --- START PROC L3C0D ---
L3C0D:  CALL    L3C4F
        JR      NC,L3C48
        LD      A,(7447h)
        LD      HL,7343h
        CP      (HL)
        JR      NC,L3C35
        LD      HL,(7344h)
        LD      A,(7392h)
        CP      L
        JR      NC,L3C35
        CP      H
        JR      NC,L3C2E
        LD      HL,(7356h)
        LD      (744Ah),HL
        RET

L3C2E:  LD      HL,(7354h)
        LD      (744Ah),HL
        RET

L3C35:  LD      HL,(7352h)
        LD      (744Ah),HL
        RET

L3C3C:  DB      0CDh
        DB      4Fh             ; 'O'
        DB      3Ch             ; '<'
        DB      30h             ; '0'
        DB      07h
        DB      2Ah             ; '*'
        DB      5Ah             ; 'Z'
        DB      73h             ; 's'
        DB      22h             ; '"'
        DB      4Ah             ; 'J'
        DB      74h             ; 't'
        DB      0C9h

L3C48:  LD      HL,(7358h)
        LD      (744Ah),HL
        RET

        ; --- START PROC L3C4F ---
L3C4F:  LD      A,(IY+00h)
        CP      58h             ; 'X'
        SCF
        RET     NZ
        LD      A,(IY+01h)
        SUB     11h
        CP      3Fh             ; '?'
        RET     C
        SUB     60h             ; '`'
        CP      3Fh             ; '?'
        RET

        ; --- START PROC L3C63 ---
L3C63:  LD      A,(7456h)
        AND     A
        RET     NZ
        LD      A,(7392h)
        AND     A
        RET     Z
        CALL    L3D17
        CP      05h
        RET     NC
        CALL    L2CD8
        LD      HL,(7F80h)
        LD      (7F00h),HL
        LD      HL,3630h
        LD      (7450h),HL
        RET

L3C83:  DB      0CDh
        DB      17h
        DB      3Dh             ; '='
        DB      0FEh
        DB      09h
        DB      0D0h
        DB      0CDh
        DB      6Ah             ; 'j'
        DB      36h             ; '6'
        DB      3Ch             ; '<'
        DB      32h             ; '2'
        DB      05h
        DB      76h             ; 'v'
        DB      0CDh
        DB      0D8h
        DB      2Ch             ; ','
        DB      0FDh
        DB      0E5h
        DB      0D1h
        DB      7Bh             ; '{'
        DB      0C6h
        DB      80h
        DB      6Fh             ; 'o'
        DB      62h             ; 'b'
        DB      01h
        DB      04h
        DB      00h
        DB      0EDh
        DB      0B0h
        DB      3Ah             ; ':'
        DB      3Ah             ; ':'
        DB      73h             ; 's'
        DB      87h
        DB      87h
        DB      0C6h
        DB      0B0h
        DB      0FDh
        DB      77h             ; 'w'
        DB      02h
        DB      3Eh             ; '>'
        DB      0Fh
        DB      0FDh
        DB      77h             ; 'w'
        DB      03h
        DB      3Ah             ; ':'
        DB      3Ah             ; ':'
        DB      73h             ; 's'
        DB      0CDh
        DB      "0=!:s4!<"
        DB      00h
        DB      0CDh
        DB      7Ch             ; '|'
        DB      2Dh             ; '-'
        DB      0CDh
        DB      8Dh
        DB      2Dh             ; '-'
        DB      21h             ; '!'
        DB      80h
        DB      7Fh
        DB      11h
        DB      00h
        DB      7Fh
        DB      01h
        DB      80h
        DB      00h
        DB      0EDh
        DB      0B0h
        DB      21h             ; '!'
        DB      00h
        DB      75h             ; 'u'
        DB      11h
        DB      00h
        DB      74h             ; 't'
        DB      01h
        DB      00h
        DB      01h
        DB      0EDh
        DB      0B0h
        DB      21h             ; '!'
        DB      00h
        DB      03h
        DB      22h             ; '"'
        DB      4Ah             ; 'J'
        DB      74h             ; 't'
        DB      0CDh
        DB      "q-:It"
        DB      87h
        DB      87h
        DB      0C6h
        DB      90h
        DB      4Fh             ; 'O'
        DB      3Ah             ; ':'
        DB      56h             ; 'V'
        DB      74h             ; 't'
        DB      0A7h
        DB      79h             ; 'y'
        DB      28h             ; '('
        DB      02h
        DB      0C6h
        DB      10h
        DB      0FDh
        DB      77h             ; 'w'
        DB      02h
        DB      3Eh             ; '>'
        DB      04h
        DB      0FDh
        DB      77h             ; 'w'
        DB      03h
        DB      0CDh
        DB      90h
        DB      3Ah             ; ':'
        DB      0FDh
        DB      7Eh             ; '~'
        DB      00h
        DB      0FEh
        DB      48h             ; 'H'
        DB      0C0h
        DB      0FDh
        DB      7Eh             ; '~'
        DB      01h
        DB      0D6h
        DB      5Ch             ; '\'
        DB      0FEh
        DB      09h
        DB      0D0h
        DB      3Eh             ; '>'
        DB      01h
        DB      "2Ft!u9"
        DB      22h             ; '"'
        DB      40h             ; '@'
        DB      74h             ; 't'
        DB      0C9h

        ; --- START PROC L3D17 ---
L3D17:  LD      HL,(7F00h)
        LD      A,(IY+00h)
        SUB     L
        JR      NC,L3D22
        NEG
L3D22:  LD      L,A
        LD      A,(IY+01h)
        SUB     H
        JR      NC,L3D2B
        NEG
L3D2B:  ADD     A,L
        RET     NC
        XOR     A
        DEC     A
        RET

L3D30:  DB      21h             ; '!'
        DB      5Ah             ; 'Z'
        DB      3Dh             ; '='
        DB      85h
        DB      6Fh             ; 'o'
        DB      30h             ; '0'
        DB      01h
        DB      24h             ; '$'
        DB      56h             ; 'V'
        DB      1Eh
        DB      00h
        DB      3Ah             ; ':'
        DB      90h
        DB      73h             ; 's'
        DB      83h
        DB      27h             ; '''
        DB      32h             ; '2'
        DB      90h
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      8Fh
        DB      73h             ; 's'
        DB      8Ah
        DB      27h             ; '''
        DB      32h             ; '2'
        DB      8Fh
        DB      73h             ; 's'
        DB      3Ah             ; ':'
        DB      8Eh
        DB      73h             ; 's'
        DB      0CEh
        DB      00h
        DB      27h             ; '''
        DB      32h             ; '2'
        DB      8Eh
        DB      73h             ; 's'
        DB      3Eh             ; '>'
        DB      01h
        DB      32h             ; '2'
        DB      38h             ; '8'
        DB      73h             ; 's'
        DB      0C9h
        DB      02h
        DB      04h
        DB      08h
        DB      16h
        DB      20h             ; ' '
        DB      50h             ; 'P'

        ; --- START PROC L3D60 ---
L3D60:  LD      A,(7338h)
        DEC     A
        RET     NZ
        LD      (7338h),A
        CALL    L3E1E
        LD      DE,7335h
        LD      HL,0059h
        CALL    L3DCE
        CALL    L3DB0
        LD      A,(7399h)
        LD      HL,733Dh
        CP      (HL)
        RET     Z
        LD      A,(738Eh)
        LD      HL,739Ah
        CP      (HL)
        RET     C
        LD      A,(7399h)
        AND     A
        JR      NZ,L3D8E
        LD      (HL),A
L3D8E:  INC     A
        CP      0FFh
        JR      Z,L3D96
        LD      (7399h),A
L3D96:  LD      A,(733Fh)
        ADD     A,(HL)
        DAA
        LD      (HL),A
        JR      NC,L3DA0
        LD      (HL),0FFh
L3DA0:  LD      A,(7391h)
        INC     A
        RET     Z
        LD      (7391h),A
        LD      A,01h
        LD      (7604h),A
        JP      L3099

        ; --- START PROC L3DB0 ---
L3DB0:  LD      DE,738Eh
        LD      HL,73CEh
        LD      A,(7332h)
        AND     A
        JR      Z,L3DBD
        EX      DE,HL
L3DBD:  PUSH    HL
        LD      HL,00B9h
        CALL    L3DCE
        POP     DE
        LD      HL,0119h
        LD      A,(7333h)
        AND     A
        JR      Z,L3E14
        ; --- START PROC L3DCE ---
L3DCE:  LD      BC,0304h
        ; --- START PROC L3DD1 ---
L3DD1:  LD      A,(DE)
        CALL    L3DE3
        CALL    L3DF1
        LD      A,(DE)
        INC     E
        CALL    L3DE7
        CALL    L3DF1
        DJNZ    L3DD1
        RET

        ; --- START PROC L3DE3 ---
L3DE3:  RRCA
        RRCA
        RRCA
        RRCA
        ; --- START PROC L3DE7 ---
L3DE7:  AND     0Fh
        ADD     A,30h           ; '0'
        CP      3Ah             ; ':'
        RET     C
        ADD     A,07h
        RET

        ; --- START PROC L3DF1 ---
L3DF1:  CP      30h             ; '0'
        JR      NZ,L3E10
        DEC     C
        JP      M,L3E10
        ; --- START PROC L3DF9 ---
L3DF9:  LD      A,20h           ; ' '
        ; --- START PROC L3DFB ---
L3DFB:  PUSH    BC
        LD      C,A
        LD      A,L
        OUT     (11h),A
        LD      A,H
        ADD     A,7Ch           ; '|'
        LD      H,A
        LD      (HL),C
        OUT     (11h),A
        SUB     7Ch             ; '|'
        LD      H,A
        INC     HL
        LD      A,C
        POP     BC
        OUT     (10h),A
        RET

        ; --- START PROC L3E10 ---
L3E10:  LD      C,00h
        JR      L3DFB

        ; --- START PROC L3E14 ---
L3E14:  LD      B,06h
        LD      A,20h           ; ' '
L3E18:  CALL    L3DFB
        DJNZ    L3E18
        RET

        ; --- START PROC L3E1E ---
L3E1E:  LD      DE,738Eh
        LD      HL,7335h
        LD      B,03h
L3E26:  LD      A,(DE)
        CP      (HL)
        RET     C
        JR      NZ,L3E30
        INC     E
        INC     L
        DJNZ    L3E26
        RET

L3E30:  LD      A,(DE)
        LD      (HL),A
        INC     E
        INC     L
        DJNZ    L3E30
        RET

        ; --- START PROC L3E37 ---
L3E37:  LD      A,(7334h)
        AND     A
        RET     M
        LD      A,(7331h)
        LD      C,A
        AND     0Fh
        RET     NZ
        LD      A,C
        RRCA
        RRCA
        RRCA
        RRCA
        LD      C,A
        LD      HL,0099h
        LD      DE,00F9h
        LD      A,(7332h)
        AND     A
        JR      Z,L3E56
        EX      DE,HL
L3E56:  PUSH    DE
        LD      A,(7334h)
        AND     C
        LD      A,(7332h)
        JR      Z,L3E62
        LD      A,02h
L3E62:  CALL    L3E75
        POP     HL
        LD      A,(7333h)
        AND     A
        JR      Z,L3E73
        LD      A,(7332h)
        XOR     01h
        JR      L3E75

        ; --- START PROC L3E73 ---
L3E73:  LD      A,02h
        ; --- START PROC L3E75 ---
L3E75:  ADD     A,A
        ADD     A,A
        LD      DE,3E88h
        ADD     A,E
        LD      E,A
        JR      NC,L3E7F
        INC     D
        ; --- START PROC L3E7F ---
L3E7F:  LD      A,(DE)
        INC     DE
        AND     A
        RET     Z
        CALL    L3DFB
        JR      L3E7F

L3E88:  DB      31h             ; '1'
        DB      55h             ; 'U'
        DB      50h             ; 'P'
        DB      00h
        DB      32h             ; '2'
        DB      55h             ; 'U'
        DB      50h             ; 'P'
        DB      00h
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      20h             ; ' '
        DB      00h

        ; --- START PROC L3E94 ---
L3E94:  LD      BC,0500h
        LD      HL,7393h
L3E9A:  LD      (HL),C
        INC     L
        DJNZ    L3E9A
        LD      (HL),01h
        JR      L3ECC

        ; --- START PROC L3EA2 ---
L3EA2:  LD      HL,7393h
        LD      A,(HL)
        INC     A
        CP      08h
        JR      C,L3EAD
        LD      A,05h
L3EAD:  LD      (HL),A
        INC     L
        LD      A,(HL)
        INC     A
        AND     07h
        LD      (HL),A
        INC     L
        INC     (HL)
        INC     L
        LD      A,(HL)
        INC     A
        CP      10h
        JR      NC,L3EBE
        LD      (HL),A
L3EBE:  INC     L
        LD      A,(HL)
        INC     A
        CP      09h
        JR      NC,L3EC6
        LD      (HL),A
L3EC6:  INC     L
        LD      A,(HL)
        ADD     A,01h
        DAA
        LD      (HL),A
        ; --- START PROC L3ECC ---
L3ECC:  CALL    L3F1D
        ; --- START PROC L3ECF ---
L3ECF:  LD      A,(7395h)
        AND     18h
        RRCA
        RRCA
        RRCA
        LD      HL,3F19h
        ADD     A,L
        LD      L,A
        JR      NC,L3EDF
        INC     H
        ; --- START PROC L3EDF ---
L3EDF:  LD      A,(HL)
        ; --- START PROC L3EE0 ---
L3EE0:  LD      (732Ah),A
        LD      (732Bh),A
        LD      (732Dh),A
        LD      (732Eh),A
        LD      (732Fh),A
        ; --- START PROC L3EEF ---
L3EEF:  LD      HL,7310h
        LD      DE,7F80h
        LD      BC,0020h
        ; --- START PROC L3EF8 ---
L3EF8:  LD      A,E
        OUT     (11h),A
        LD      A,D
        OUT     (11h),A
L3EFE:  DEC     BC
        LD      A,C
        OR      B
        LD      A,(HL)
        INC     HL
        OUT     (10h),A
        JR      NZ,L3EFE
        RET

        ; --- START PROC L3F08 ---
L3F08:  LD      A,(7331h)
        AND     07h
        RET     NZ
        LD      A,(7331h)
        AND     08h
        JR      NZ,L3ECF
        LD      A,0F0h
        JR      L3EE0

L3F19:  DB      50h             ; 'P'
        DB      30h             ; '0'
        DB      0E0h
        DB      0B0h

        ; --- START PROC L3F1D ---
L3F1D:  LD      HL,7393h
        LD      A,(HL)
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,(HL)
        LD      HL,3F4Eh
        ADD     A,L
        LD      L,A
        JR      NC,L3F2D
        INC     H
L3F2D:  LD      DE,7341h
        LD      BC,0009h
        LDIR
        LD      HL,7341h
        LD      A,(HL)
        ADD     A,A
        ADD     A,(HL)
        ADD     A,A
        ADD     A,A
        LD      HL,3F96h
        ADD     A,L
        LD      L,A
        JR      NC,L3F45
        INC     H
L3F45:  LD      DE,7350h
        LD      BC,000Ch
        LDIR
        RET

L3F4E:  DB      00h
        DB      00h
        DB      01h
        DB      09h
        DB      05h
        DB      0E0h
        DB      01h
        DB      68h             ; 'h'
        DB      01h
        DB      00h
        DB      01h
        DB      02h
        DB      0Bh
        DB      05h
        DB      90h
        DB      01h
        DB      68h             ; 'h'
        DB      01h
        DB      01h
        DB      00h
        DB      02h
        DB      0Bh
        DB      05h
        DB      68h             ; 'h'
        DB      01h
        DB      2Ch             ; ','
        DB      01h
        DB      01h
        DB      01h
        DB      03h
        DB      0Dh
        DB      07h
        DB      2Ch             ; ','
        DB      01h
        DB      0F0h
        DB      00h
        DB      02h
        DB      02h
        DB      03h
        DB      0Bh
        DB      05h
        DB      0F0h
        DB      00h
        DB      0B4h
        DB      00h
        DB      01h
        DB      02h
        DB      04h
        DB      11h
        DB      09h
        DB      0F0h
        DB      00h
        DB      78h             ; 'x'
        DB      00h
        DB      02h
        DB      03h
        DB      03h
        DB      0Dh
        DB      07h
        DB      78h             ; 'x'
        DB      00h
        DB      01h
        DB      00h
        DB      03h
        DB      03h
        DB      04h
        DB      11h
        DB      09h
        DB      3Ch             ; '<'
        DB      00h
        DB      3Ch             ; '<'
        DB      00h
        DB      0F0h
        DB      00h
        DB      0E0h
        DB      00h
        DB      0F0h
        DB      00h
        DB      00h
        DB      01h
        DB      80h
        DB      00h
        DB      80h
        DB      00h
        DB      0F0h
        DB      00h
        DB      0F0h
        DB      00h
        DB      00h
        DB      01h
        DB      10h
        DB      01h
        DB      90h
        DB      00h
        DB      90h
        DB      00h
        DB      00h
        DB      01h
        DB      00h
        DB      01h
        DB      10h
        DB      01h
        DB      20h             ; ' '
        DB      01h
        DB      0A0h
        DB      00h
        DB      0A0h
        DB      00h
        DB      10h
        DB      01h
        DB      00h
        DB      01h
        DB      20h             ; ' '
        DB      01h
        DB      40h             ; '@'
        DB      01h
        DB      0B0h
        DB      00h
        DB      0B0h
        DB      00h
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
        DB      0FFh
