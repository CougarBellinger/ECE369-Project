# display [PC value], [Reg value]
.text
main:
loop:
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
    j test1
        nop
        nop
        nop
        nop
        nop
test1:  nop
        nop
        nop
        nop
        nop
        nop
        sw $t1, 0($t0) # display 72, (no register written)
        nop
        nop
        nop
        nop
        nop
    sw $t2, 4($t0) # display 96, 0
        nop
        nop
        nop
        nop
        nop
    lw $s0, 0($t0) # s0 = 6, display 120, 6
        nop
        nop
        nop
        nop
        nop
    lw $s1, 4($t0) # s1 = 10, display 144, 10
        nop
        nop
        nop
        nop
        nop
    sub $t3, $s1, $s0 # t3 = 10-6 = 4, display 168, 4
        nop
        nop
        nop
        nop
        nop
    sll $t4, $t3, 3 # t4 = 4 << 3 = 64, display 192, 64
        nop
        nop
        nop
        nop
        nop
    srl $t5, $t4, 2 # t5 = 16 64 >> 2, display 216, 2
        nop
        nop
        nop
        nop
        nop
    add $t6, $t1, $t2 # t6 = 6 + 10 = 16 display 240, 16
        nop
        nop
        nop
        nop
        nop
    mul $t7, $t1, $t2 # t7 = 6 * 10 = 60 display 264, 60
        nop
        nop
        nop
        nop
        nop 
    and $t8, $t1, $t2 # t8 = 6 and 10 = 0110 and 1010 = 0010 display 288, 2
        nop
        nop
        nop
        nop
        nop
    andi $t9, $t1, 3 # t9 = 6 and 7 = 0110 and 0111 = 0110 display 312, 6
        nop
        nop
        nop
        nop
        nop
    or $t0, $t3, $t2 # t0 = 4 or 10 = 0100 or 1010 = 1110 display 336, 14
        nop
        nop
        nop
        nop
        nop 
    ori $t1, $t3, 8 # t0 = 4 or 8 = 0100 or 1000 = 1100 display 360, 12
        nop
        nop
        nop
        nop
        nop
    nor $t2, $t1, $t9 # t2 = 12 nor 6 = 1100 nor 0110 = 0001 display 384, 1
        nop
        nop
        nop
        nop
        nop
    xor $t3, $t1, $t9 # t3 = 12 xor 6 = 1100 xor 0110 = 1010 display 408, 10
        nop
        nop
        nop
        nop
        nop
    xori $t4, $t1, 3 # t4 = 12 xor 3 = 1100 xor 0011 = 0000 display 432, 0
        nop
        nop
        nop
        nop
        nop
    slt $t5, $t3, $t1 # t5 = 10 < 12 display 456, 1
        nop
        nop
        nop
        nop
        nop
    slti $t6, $t3, 15 # t6 = 10 < 15 display 480, 1
        nop
        nop
        nop
        nop
        nop
    lb $s2, 2($t0) # s2 = load byte into from memory address(2 + 14 = 16), display 504, 16
        nop
        nop
        nop
        nop
        nop
    lh $s3, 3($t0) # s2 = load half into from memory address(3 + 14 = 17), display 528, 17
        nop
        nop
        nop
        nop
        nop
    sw $t2, 4($t0) # display 552, 18
        nop
        nop
        nop
        nop
        nop
    sb $t3, 5($t0) # display 576, 19
        nop
        nop
        nop
        nop
        nop
    sh $t4, 6($t0) # display 600, 20 
        nop
        nop
        nop
        nop
        nop
    add $t5, $zero, $zero # t5 = 0 display 624, 0
        nop
        nop
        nop
        nop
        nop
    bgez $t1, branch_test_1 # 12 >= 0 so branches display 648, 0
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 100 # s4 = 100 display 672, 100
        nop
        nop
        nop
        nop
        nop
    branch_test_1:
        addi $s4, $t5, 101 # s4 = 101 display 696, 101
        nop
        nop
        nop
        nop
        nop
    bltz $t1, branch_test_2 # 12 not < 0 so does not branch display 720, 0
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 200 # s4 = 200 display 744, 200
        nop
        nop
        nop
        nop
        nop
    branch_test_2:
        addi $s4, $t5, 201 # s4 = 201 display 768, 201
        nop
        nop
        nop
        nop
        nop
    blez $t1, branch_test_3 # 12 not <= 0 so does not branch display 792, 0
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 300 # s4 = 300 display 816, 300
        nop
        nop
        nop
        nop
        nop
    branch_test_3:
        addi $s4, $t5, 3 # s4 = 301 display 840, 301
        nop
        nop
        nop
        nop
        nop
    bgtz $t1, branch_test_4 # 12 > 0 so branches display 864, 0
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 400 # s4 = 400 display 888, 400
        nop
        nop
        nop
        nop
        nop
    branch_test_4:
    addi $s4, $t5, 401 # s4 = 401 display 912, 401
        nop
        nop
        nop
        nop
        nop
    beq $t5, $t8, branch_test_5 # 2 = 2 so branches display 936, 0
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 500 # s4 = 500 display 960, 500
        nop
        nop
        nop
        nop
        nop
    branch_test_5:
        addi $s4, $t5, 501 # s4 = 501 display 984, 501
        nop
        nop
        nop
        nop
        nop
    bne	$t0, $t1, branch_test_6 # 14 != 12 so branches display 1008, 0    
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 600 # s4 = 600 display 1032, 600
        nop
        nop
        nop
        nop
        nop
    branch_test_6:
        addi $s4, $t5, 601 # s4 = 601 display 1056, 601
        nop
        nop
        nop
        nop
        nop
    j target_1 # display 1080, 0
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 700 # s4 = 700 display 1104, 700
        nop
        nop
        nop
        nop
        nop     
    target_1:
        addi $s4, $t5, 701 # s4 = 701 display 1128, 701
        nop
        nop
        nop
        nop
        nop
    jal target_2 # display 1152, 0          
        nop
        nop
        nop
        nop
        nop
    addi $s4, $t5, 901 # s4 = 901 display 1176, 901
        nop
        nop
        nop
        nop
        nop
    beq $t5, $zero, exit # display 1200, 0
        nop
        nop
        nop
        nop
        nop
    target_2:
        addi $s4, $t5, 801 # s4 = 801 display 1224, 801
        nop
        nop
        nop
        nop
        nop
    jr $ra # display 1248, 0
        nop
        nop
        nop
        nop
        nop
    exit:
        j loop # display 1272, 0