.text
main:
addi $t0, $zero, 0 # t0=0, display 0, 0
    nop
    nop
    nop
    nop
    nop
addi $t1, $zero, 6 # t1= 6, display 24, 6
    nop
    nop
    nop
    nop
    nop
addi $t2, $zero, 10 # t2 = 10, display 48, 10
    nop
    nop
    nop
    nop
    nop
addi $s0, $zero, -1 # s0 = - 1, display 72, -1
    nop
    nop
    nop
    nop
    nop
and $t0, $t1, $t2 # t0 = 0110 and 1010 = 0010 = 2 display 96, 2
    nop
    nop
    nop
    nop
    nop
andi $t0, $t1, 3 # t0 = 110 and 011 = 010 = 2 display ?, 2
    nop
    nop
    nop
    nop
    nop
or $t0, $t1, $t2 # t0 = 0110 or 1010 = 1110 = 14 display ?, 14
    nop
    nop
    nop
    nop
    nop
nor $t0, $t1, $t2 # t0 = 0110 or 1010 = 1110 = 0001 = 1 display ?, 1
    nop
    nop
    nop
    nop
    nop
xor $t0, $t1, $t2 # t0 = 0110 xor 1010 = 1100 display ?, 12
    nop
    nop
    nop
    nop
    nop
ori $t0, $t1, 8 # t0 = 0110 or 1000 = 1110 display ?, 14
    nop
    nop
    nop
    nop
    nop
xori $t0, $t1, 7 # t0 = 0110 xor 0111 = 0001 display ?, 1
    nop
    nop
    nop
    nop
    nop
sll $t0, $t2, 3 # t4 = 10 << 3 = 1000, display ?, 1000 1010 << 3 = 1010000 80 decimal, works!
    nop
    nop
    nop
    nop
    nop
srl $t0, $t1, 2 # t0 = 6 >> 2, display ?, ? 0110 >> 2 = 0001 = 1 decimal works!
    nop
    nop
    nop
    nop
    nop
slt $t0, $t1, $t2 # t0 = 6 < 10 display ?, 1
    nop
    nop
    nop
    nop
    nop
slt $t0, $t1, $s0 # t0 = 6 < -1 display ?, 0
    nop
    nop
    nop
    nop
    nop
slt $t0, $s0, $t1 # t0 = -1 < 6 display ?, 1
    nop
    nop
    nop
    nop
    nop
slti $t0, $t2, 15 # t6 = 10 < 15 display ?, 1
    nop
    nop
    nop
    nop
    nop
slti $t0, $t2, -1 # t6 = 10 < -1 display ?, 1
    nop
    nop
    nop
    nop
    nop