# addi  x5,  x0,  0xa
# add   x6,  x5,  x5
# addi  x7,  x5,  0x1
# add   x7,  x7,  x6
# add   x7,  x7,  x7
li    x8,  0x100
li    x9,  0x101
# jal   loop
# sw    x5,  0(x8)
# sw    x6,  0x100(x8)
# sw    x7,  0x200(x8)
# lw    x7,  0(x8)
# loop:
# addi  x7,  x7,  0x1
# addi  x0,  x0,  0x1
# sw    x7,  0x300(x8)
# slti  x9,  x7,  0xf
sw    x8,  0(x8)
sw    x9,  0x100(x8)
nop
nop
# lw    x9,  0x100(x8)
# sw    x9,  0(x8)
addi  x0,  x0,  0x2
add   x10, x0,  x0
wfi