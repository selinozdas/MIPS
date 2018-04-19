.data
si: .asciiz "enter size(1-20):"
num: .asciiz "enter number:"
pr: .asciiz "list: "
rv: .asciiz "\nreversed list: "
.text
addi $t4 $0 21
size:
    la $a0 si
    li $v0 4
    syscall

    la $a0 0($v0) 
    li $v0 5	#syscall for read integer is 5
    syscall		#system call
    addi $t0 $v0 0	#move size of the array to t0
    slt $t2 $t0 $t4
    beq $t2 0 size
    beq $t0 0 size

li $v0 9		#syscall for allocating memory in heap
syscall
addi $t7 $v0 0
addi $t5 $v0 -4
addi $t2 $v0 0
addi $a0 $v0 0

fill:
    la $a0 num
    li $v0 4
    syscall
    li $v0 5
    syscall
    sw $v0 0($t2)
    addi $t1 $t1 1
    addi $t2 $t2 4
    bne $t1 $t0 fill
    
la $a0 pr
li $v0 4
syscall

print:
    li $v0 1
    lw $t6 0($t7) 
    addi $a0 $t6 0
    syscall
    addi $t7 $t7 4
    bne $t7 $t2 print

addi $t7 $t7 -4

la $a0 rv
li $v0 4
syscall

reverse:
    li $v0 1
    lw $t6 0($t7) 
    addi $a0 $t6 0
    syscall
    addi $t7 $t7 -4
    bne $t7 $t5 reverse   

