.text
main:

addi $t3, $zero, 4 # display 0, 4
sll $t4, $t3, 3 # t4 = 4 << 3 = 64, display 4, 64
srl $t5, $t4, 2 # t5 = 16 64 >> 2, display 8, 2