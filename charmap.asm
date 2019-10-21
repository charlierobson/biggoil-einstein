    .asciimap 0,255,$0f             ; default case, '?'
    .asciimap ' ',' ',0
    .asciimap '"','"',$0b
    .asciimap '£','£',$0c
    .asciimap '$','$',$0d
    .asciimap ':',':',$0e
    .asciimap '(','(',$10
    .asciimap ')',')',$11
    .asciimap '>','>',$12
    .asciimap '<','<',$13
    .asciimap '=','=',$14
    .asciimap '+','+',$15
    .asciimap '-','-',$16
    .asciimap '*','*',$17
    .asciimap '/','/',$18
    .asciimap ';',';',$19
    .asciimap ',',',',$1a
    .asciimap '.','.',$1b
    
    .asciimap $5c,$5c,$40   ; backslash
    .asciimap '[','[',$41
    .asciimap ']',']',$42
    .asciimap '^','^',$43
    .asciimap '_','_',$44
    .asciimap '!','!',$45
    .asciimap $2c,$2c,$46   ; single quote
    .asciimap '@','@',$60
    
    .asciimap '0','9',{*}-'0'+$1c
    .asciimap 'a','z',{*}-'a'+$26
    .asciimap 'A','Z',{*}-'A'+$26
