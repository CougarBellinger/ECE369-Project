.text
main: 
addi $t0, $zero, 0 # t0=0, display ?, 0
    nop
    nop
    nop
    nop
    nop
addi $t1, $zero, 6 # t1= 6, display ?, 6
    nop
    nop
    nop
    nop
    nop
addi $t2, $zero, 10 # t2 = 10, display ?, 10
    nop
    nop
    nop
    nop
    nop
addi $t3, $zero, -1 # t3 = - 1, display ?, -1
    nop
    nop
    nop
    nop
    nop
sw $t1, 0($t0) # display ?, (no register written)
    nop
    nop
    nop
    nop
    nop
sw $t2, 4($t0) # display ?, 0
    nop
    nop
    nop
    nop
    nop
sw $t3, 8($t0) # display ?, 0
    nop
    nop
    nop
    nop
    nop
sh $t3, 12($t0) # display ?, 0 
    nop
    nop
    nop
    nop
    nop
sb $t3, 16($t0) # display ?, 0
    nop
    nop
    nop
    nop
    nop

lw $s0, 0($t0) # s0 = 6, display ?, 6
    nop
    nop
    nop
    nop
    nop
lw $s1, 4($t0) # s1 = 10, display ?, 10
    nop
    nop
    nop
    nop
    nop
lw $s2, 8($t0) # s2 = -1, display ?, -1
    nop
    nop
    nop
    nop
    nop
lh $s3, 8($t0) # s2 = 65535, display ?, 65535
    nop
    nop
    nop
    nop
    nop
lb $s4, 8($t0) # s2 = 255, display ?, 255
    nop
    nop
    nop
    nop
    nop
lw $s5, 12($t0) # s2 = 65535, display 65535
    nop
    nop
    nop
    nop
    nop
lw $s6, 16($t0) # s2 = 255, display 255
    nop
    nop
    nop
    nop
    nop
