.data
si: .asciiz "enter array size(1-20):"
num: .asciiz "enter number:"
menu: .asciiz "\nMenu:\n1.sort\n2.minmax\n3.median\n4.quit\nEnter:"
mini:.asciiz "min: "
maxi:.asciiz " max: "
sorted: .asciiz "sorted list: "
entry: .asciiz "\n"
medy: .asciiz "Median: "
.text

################################################## FILL
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

addi $s0 $v0 0

addi $t9 $v0 0

fill:
    la $a0 num
    li $v0 4
    syscall
    li $v0 5
    syscall
    sw $v0 0($t9)
    addi $t1 $t1 1
    addi $t9 $t9 4
    bne $t1 $t0 fill
################################################### MENU
menus:	la $a0 menu
	li $v0 4
	syscall
	li $v0 5
	syscall
	beq $v0 1 sortstart
	beq $v0 2 mmm
	beq $v0 3 median
	b quit
################################################## SORT
sortstart:
	jal sort
	b menus
sort:

addi $t9 $t9 -4
addi $t4 $s0 0
outSort:
	addi $t8 $s0 0
	addi $t2 $zero 0 
	#0 is false 1 is true
inSort:
	
	lw $t6 0($t8)
	lw $t7 4($t8)
	slt  $t5 $t7 $t6
	bne $t5 1 skip
swap:
	move $t5 $t6
	move $t6 $t7
	move $t7 $t5
	sw $t6 0($t8)
	sw $t7 4($t8)
	addi $t2 $zero 1
skip:
	addi $t8 $t8 4
	bne $t8 $t9 inSort
	
	beq $t2 0 end
	addi $t4 $t4 4
	bne $t4 $t9 outSort
end:

addi $t9 $t9 4
   la $a0 sorted
    li $v0 4
    syscall
addi $t8 $s0 0
print:
    li $v0 1
    lw $t6 0($t8) 
    addi $a0 $t6 0
    syscall
    addi $t8 $t8 4
    bne $t8 $t9 print
la $a0 entry
    li $v0 4
    syscall
jr $ra
b menus
######################################## MIN MAX
mmm:
addi $t8 $s0 0
lw $t2 0($t8)
minmax: 
	lw $t5 0($t8)
	slt $t4 $t5 $t2
	beq $t4 1 min
	slt $t4 $t3 $t5
	beq $t4 1 max
	b resume
min:	addi $t2 $t5 0
	b resume
max:	addi $t3 $t5 0
resume:	addi $t8 $t8 4
	bne $t8 $t9 minmax

addi $t8 $s0 0
la $a0 mini
    li $v0 4
    syscall
la $a0 ($t2)
    li $v0 1
    syscall
  
la $a0 maxi
    li $v0 4
    syscall
la $a0 ($t3)
    li $v0 1
    syscall
la $a0 entry
    li $v0 4
    syscall
b menus
######################################### MEDIAN
median:
jal sort
addi $t9 $t9 4

	addi $t8 $s0 0
	addi $t4 $zero 0
	andi $t5 $t0 1
	sra $t6 $t0 1
	mul $t6 $t6 4
	beq $t5 1 odd
even:	add $t8 $t8 $t6
	lw $t2 -4($t8)
	lw $t3 ($t8)
	add $t2 $t3 $t2
	sra $t2 $t2 1
	b a
odd:	add $t8 $t8 $t6
	lw $t2 ($t8)
	la $a0 medy
a:   li $v0 4
    syscall
la $a0 ($t2)
    li $v0 1
    syscall
la $a0 entry
    li $v0 4
    syscall
b menus
quit:

