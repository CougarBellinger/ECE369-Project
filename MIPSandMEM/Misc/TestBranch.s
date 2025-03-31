.text
main:
addi $t0, $zero, 0 # t0=0, display 0, 0
        nop
        nop
        nop
        nop
        nop
    addi $t1, $zero, 11 # t1= 11, display 24, 6
        nop
        nop
        nop
        nop
        nop
    addi $t2, $zero, 12 # t2 = 12, display 48, 10
        nop
        nop
        nop
        nop
        nop
    sw $t1, 0($t0) # display 72, 0 saves 11 into data memory
        nop
        nop
        nop
        nop
        nop
    sw $t2, 4($t0) # display 96, 0 saves 12 into data memory
        nop
        nop
        nop
        nop
        nop
    lw $s0, 0($t0) # s0 = 11, display 120, 6
        nop
        nop
        nop
        nop
        nop
    lw $s1, 4($t0) # s1 = 12, display 144, 10
        nop
        nop
        nop
        nop
        nop
    addi $s2, $t0, -1 # set $s2 = -1
        nop
        nop
        nop
        nop
        nop
    beq $s1, $s0, exit # should be PCSRC = 0 12 != 11
        nop
        nop
        nop
        nop
        nop
    bne $s1, $s0, bnetest # should be PCSRC = 1 12 != 11
        nop
        nop
        nop
        nop
        nop
    j exit
bnetest:
        nop
        nop
        nop
        nop
        nop
    addi $s0, $s0, 1 # s1 = 12, display 144, 10
        nop
        nop
        nop
        nop
        nop
    beq $s1, $s0, beqtest # should be PCSRC = 1 12 == 12
        nop
        nop
        nop
        nop
        nop
    j exit
beqtest:
        nop
        nop
        nop
        nop
        nop
    bne $s1, $s0, exit # should be PCSRC = 0 12 == 12
        nop
        nop
        nop
        nop
        nop
    bgez $t0, bgeztest1 # should be PCSRC = 1 0 >= 0
        nop
        nop
        nop
        nop
        nop
    j exit
bgeztest1:
        nop
        nop
        nop
        nop
        nop
    bgez $s1, bgeztest2 # should be PCSRC = 1 12 >= 0
        nop
        nop
        nop
        nop
        nop
    j exit
bgeztest2:
        nop
        nop
        nop
        nop
        nop
    bgez $s2, exit  # should be PCSRC = 0 -1 < 0
        nop
        nop
        nop
        nop
        nop
    bltz $t0, exit # should be PCSRC = 0 0 == 0
        nop
        nop
        nop
        nop
        nop
    bltz $s1, exit # should be PCSRC = 0 12 > 0
        nop
        nop
        nop
        nop
        nop  
    bltz $s2, bltztest1 # should be PCSRC = 1 -1 < 0 
        nop
        nop
        nop
        nop
        nop
    j exit
bltztest1:
        nop
        nop
        nop
        nop
        nop
    blez $t0, bleztest1 # should be PCSRC = 1 0 == 0
        nop
        nop
        nop
        nop
        nop
        j exit
bleztest1:
        nop
        nop
        nop
        nop
        nop
    blez $s1, exit # should be PCSRC = 0 12 > 0
        nop
        nop
        nop
        nop
        nop  
    blez $s2, bleztest2 # should be PCSRC = 1 -1 =< 0 
        nop
        nop
        nop
        nop
        nop
        j exit
bleztest2:
        nop
        nop
        nop
        nop
        nop
    bgtz $t0, exit # should be PCSRC = 0 0 == 0
        nop
        nop
        nop
        nop
        nop
    bgtz $s1, bgtztest # should be PCSRC = 1 12 >= 0
        nop
        nop
        nop
        nop
        nop
        j exit
bgtztest:
        nop
        nop
        nop
        nop
        nop
    bgtz $s2, exit  # should be PCSRC = 0 -1 < 0 
        nop
        nop
        nop
        nop
        nop
    j jtest
        nop
        nop
        nop
        nop
        nop
    j exit
jtest:
        nop
        nop
        nop
        nop
        nop
    jal jaltest
        nop
        nop
        nop
        nop
        nop
    addi $s2, $s2, 421 # distinct final value for end of test
    j exit
jaltest:
        nop
        nop
        nop
        nop
        nop
    jr $ra # ra should be the same as PC from jal + 4 //works!
        nop
        nop
        nop
        nop
        nop
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