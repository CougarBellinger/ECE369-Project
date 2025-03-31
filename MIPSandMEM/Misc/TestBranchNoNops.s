.text
main:
addi $t0, $zero, 0 # t0=0, display 0, 0
    addi $t1, $zero, 11 # t1= 11, display 24, 6
    addi $t2, $zero, 12 # t2 = 12, display 48, 10
    sw $t1, 0($t0) # display 72, 0 saves 11 into data memory
    sw $t2, 4($t0) # display 96, 0 saves 12 into data memory
    lw $s0, 0($t0) # s0 = 11, display 120, 6
    lw $s1, 4($t0) # s1 = 12, display 144, 10
    addi $s2, $t0, -1 # set $s2 = -1
    beq $s1, $s0, exit # should be PCSRC = 0 12 != 11
    bne $s1, $s0, bnetest # should be PCSRC = 1 12 != 11
    j exit
bnetest:
    addi $s0, $s0, 1 # s1 = 12, display 144, 10
    beq $s1, $s0, beqtest # should be PCSRC = 1 12 == 12
    j exit
beqtest:
    bne $s1, $s0, exit # should be PCSRC = 0 12 == 12
    bgez $t0, bgeztest1 # should be PCSRC = 1 0 >= 0
    j exit
bgeztest1:
    bgez $s1, bgeztest2 # should be PCSRC = 1 12 >= 0
    j exit
bgeztest2:
    bgez $s2, exit  # should be PCSRC = 0 -1 < 0
    bltz $t0, exit # should be PCSRC = 0 0 == 0\
    bltz $s1, exit # should be PCSRC = 0 12 > 0  
    bltz $s2, bltztest1 # should be PCSRC = 1 -1 < 0 
    j exit
bltztest1:
    blez $t0, bleztest1 # should be PCSRC = 1 0 == 0
        j exit
bleztest1:
    blez $s1, exit # should be PCSRC = 0 12 > 0
    blez $s2, bleztest2 # should be PCSRC = 1 -1 =< 0 
        j exit
bleztest2:
    bgtz $t0, exit # should be PCSRC = 0 0 == 0
    bgtz $s1, bgtztest # should be PCSRC = 1 12 >= 0
        j exit
bgtztest:
    bgtz $s2, exit  # should be PCSRC = 0 -1 < 0 
    j jtest
    j exit
jtest:
    jal jaltest
    addi $s2, $s2, 421 # distinct final value for end of test
    j exit
jaltest:
    jr $ra # ra should be the same as PC from jal + 4 //works!
exit:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop