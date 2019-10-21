function addentry {
    eps+='--entry:0x'
    eps+=$1
    eps+=' '
}

eps=''
addentry 2007
addentry 2081
addentry 209c
addentry 20c1
addentry 23e3
addentry 2B6B
addentry 2B75
addentry 2B88
addentry 2B9B
addentry 2BAE
addentry 2BC1
addentry 2BCD
addentry 2BE0
addentry 2D71
addentry 2D7C
addentry 2D8D
addentry 2DA1
addentry 2DF0
addentry 2EAB
addentry 2B5B
addentry 3204
addentry 3216
addentry 32CC
addentry 334A
addentry 33FD
addentry 3962
addentry 3965
addentry 3A0B
addentry 3AA9
addentry 3B1A
addentry 3B20
addentry 3B29
addentry 3B47
addentry 3B60
addentry 3B82
addentry 3B93
addentry 3C05
addentry 3C0B

echo ".define DB .db" > pp.asm
echo ".define DW .dw" >> pp.asm
echo ".define ORG .org" >> pp.asm
echo "" >> pp.asm
echo "  ORG 2000h" >> pp.asm
echo "  DB 02h" >> pp.asm
echo "  DW 2007h" >> pp.asm
echo "  DW 2D7Bh" >> pp.asm
echo "  DW 2D7Bh" >> pp.asm
echo "" >> pp.asm

mono /usr/local/bin/yazd.exe --addr:0x2007 --header:7 $eps ../m5multi/cart-binaries/ola/PowerPac\ \(PAL\).rom >> pp.asm

sed "s/RST     0x38/RST     38h/g" pp.asm >powerpac.asm

rm pp.asm

