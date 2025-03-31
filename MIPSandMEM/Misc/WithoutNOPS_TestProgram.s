# display [PC value], [Reg value]
# nrw = no register written
.text
main:
loop:
    addi $t0, $zero, 0 # t0=0, display 0, 0
    addi $t1, $zero, 6 # t1= 6, display 4, 6
    addi $t2, $zero, 10 # t2 = 10, display 8, 10
    j test1

    test1:
        sw $t1, 0($t0) # display 12, (no register written)
        
    sw $t2, 4($t0) # display 16, nrw
    lw $s0, 0($t0) # s0 = 6, display 20, 6
    lw $s1, 4($t0) # s1 = 10, display 24, 10
    sub $t3, $s1, $s0 # t3 = 10-6 = 4, display 28, 4
    sll $t4, $t3, 3 # t4 = 4 << 3 = 64, display 32, 32
    srl $t5, $t4, 2 # t5 = 16 64 >> 2, display 36, 8
    add $t6, $t1, $t2 # t6 = 6 + 10 = 16 display 40, 16
    mul $t7, $t1, $t2 # t7 = 6 * 10 = 60 display 44, 60
    and $t8, $t1, $t2 # t8 = 6 and 10 = 0110 and 1010 = 0010 display 48, 2
    andi $t9, $t1, 7 # t9 = 6 and 7 = 0110 and 0111 = 0110 display 52, 6
    or $t0, $t3, $t2 # t0 = 4 or 10 = 0100 or 1010 = 1110 display 56, 14
    ori $t1, $t3, 8 # t0 = 4 or 8 = 0100 or 1000 = 1100 display 60, 12
    nor $t2, $t1, $t9 # t2 = 12 nor 6 = 1100 nor 0110 = 0001 display 64, -13            ??
    xor $t3, $t1, $t9 # t3 = 12 xor 6 = 1100 xor 0110 = 1010 display 68, 14             ??
    xori $t4, $t1, 3 # t4 = 12 xor 3 = 1100 xor 0011 = 0000 display 72, 15
    slt $t5, $t3, $t1 # t5 = 10 < 12 display 76, 0
    slti $t6, $t3, 15 # t6 = 10 < 15 display 80, 1
    lb $s2, 2($t0) # s2 = load byte into from memory address(2 + 14 = 16), display 84, 16?       ??
    lh $s3, 3($t0) # s2 = load half into from memory address(3 + 14 = 17), display 88, 17?       ??
    sw $t2, 4($t0) # display 92, nrw
    sb $t3, 5($t0) # display 96, nrw
    sh $t4, 6($t0) # display 100, nrw
    add $t5, $zero, $zero # t5 = 0 display 104, 0
    bgez $t1, branch_test_1 # 12 >= 0 so branches display 108, 0
    addi $s4, $t5, 100 # s4 = 100 display 112, 100                                               

    branch_test_1:
        addi $s4, $t5, 101 # s4 = 101 display 116, 101
    
    bltz $t1, branch_test_2 # 12 not < 0 so does not branch display 120, 0
    addi $s4, $t5, 200 # s4 = 200 display 124, 200
    
    branch_test_2:
        addi $s4, $t5, 201 # s4 = 201 display 128, 201
    
    blez $t1, branch_test_3 # 12 not <= 0 so does not branch display 132, 0
    addi $s4, $t5, 300 # s4 = 300 display 136, 300

    branch_test_3:
        addi $s4, $t5, 3 # s4 = 301 display 140, 3
    
    bgtz $t1, branch_test_4 # 12 > 0 so branches display 144, 0
    addi $s4, $t5, 400 # s4 = 400 display 148, 400
        
    branch_test_4:
        addi $s4, $t5, 401 # s4 = 401 display 152, 401
    
    beq $t5, $t8, branch_test_5 # 0 != 2 so does not branch display 156, 0
    addi $s4, $t5, 500 # s4 = 500 display 160, 500
    
    branch_test_5:
        addi $s4, $t5, 501 # s4 = 501 display 164, 501
        
    bne	$t0, $t1, branch_test_6 # 14 != 12 so branches display 168, 0       
    addi $s4, $t5, 600 # s4 = 600 display 172, 600
       
    branch_test_6:
        addi $s4, $t5, 601 # s4 = 601 display 176, 601
        
    j target_1 # display 180, 0
    addi $s4, $t5, 700 # s4 = 700 display 184, 700
            
    target_1:
        addi $s4, $t5, 701 # s4 = 701 display 188, 701
        
    jal target_2 # display 192, 0          
        
    addi $s4, $t5, 901 # s4 = 901 display 196, 901                            ??
        
    beq $t5, $zero, exit # display 200, 0
       
    target_2:
        addi $s4, $t5, 801 # s4 = 801 display 204, 801
        
    jr $ra # display 208, 0
        
    exit:
        j loop # display 212, 0