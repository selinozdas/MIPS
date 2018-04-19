.data
si: .asciiz "enter size(1-100):"
num: .asciiz "enter number:"
aption: .asciiz "Sum of n>array elements: "
bption: .asciiz "Occurences: "
ception: .asciiz "Sum of even: "
coption: .asciiz "\nSum of odd: "
cbm: .asciiz "enter 1,2,3 or 4: "
term: .asciiz "\nterminated"

.text
addi $t4 $0 101		#max size
size:
#asks user-- array size
	    la $a0 si
	    li $v0 4		#syscall print
	    syscall		
	    la $a0 0($v0) 
	    li $v0 5		#syscall for read integer is 5
	    syscall
	    addi $t0 $v0 0	#move size of the array to t0
	    slt $t2 $t0 $t4	#if input is less than 100 set t2 1
   	 beq $t2 0 size	#if input is more than 100, reenter
    	beq $t0 0 size	#if input is zero, reenter
#memory alloc
li $v0 9		#syscall for dynamically allocating memory in heap
syscall
addi $t7 $v0 0		#const addr pointer(do not change it!!)
addi $t2 $v0 0		#addr mem loc

#fills array
fill:
    	la $a0 num		#syscall fill
    	li $v0 4		
    	syscall		
    	li $v0 5		
    	syscall		
    	sw $v0 0($t2)	#store input word
    	addi $t1 $t1 1	#i =i+1
    	addi $t2 $t2 4	#j=j+1
	bne $t1 $t0 fill	#repeat if i!=size
	
menu:
	la $a0 cbm
	li $v0 4
	syscall
	la $a0 0($v0) 
	li $v0 5		#syscall for read integer is 5
	syscall
	addi $t6 $v0 0 
	beq $t6 0 quit
	beq $t6 3 occ
	beq $t6 2 eoro
	beq $t6 1 grs
	bne $t6 4 menu

grs:	
	la $a0 num
	li $v0 4		#syscall print
	syscall		
	la $a0 0($v0) 
	li $v0 5		#syscall for read integer is 5
	syscall
	addi $t3 $t7 0		#resets address of the pointer
	addi $t5 $v0 0		#n
	
loop:
	lw  $s1	0($t3)	#arr[i]
	slt $t9 $t5 $s1
	addi $t3 $t3 4
	addi $t8 $t8 1
	bne $t9 1 skip
	add $s7 $s7 $s1
skip:
	bne $t8 $t0 loop
	la $a0 ($s7)
	li $v0 1		#syscall print
	syscall	
	b quit

eoro:	
	addi $t3 $t7 0		#reset pointer		
set:	
	lw $s6 0($t3)
	andi $t9 $s6 1
	beq $t9 1 oddsum
evensum:
	add $s4 $s4 $s6
	b count
oddsum: 
	add $s5 $s5 $s6
count:  
	addi $t3 $t3 4
	addi $t8 $t8 1
	bne $t8 $t0 set
	la $a0 ception
	li $v0 4		#syscall print
	syscall	
	la $a0 ($s4)
	li $v0 1		#syscall print
	syscall
	la $a0 coption
	li $v0 4		#syscall print
	syscall	
	la $a0 ($s5)
	li $v0 1		#syscall print
	syscall
	b quit
occ:
	la $a0 num
	li $v0 4		#syscall print
	syscall		
	la $a0 0($v0) 
	li $v0 5		#syscall for read integer is 5
	syscall
	addi $t3 $t7 0		#resets address of the pointer
	addi $t5 $v0 0		#n
	li $s4 0
focc:	lw $s1 0($t3)		#x = arr[i]
	lw $t9 0($t3) 
	div $t9 $t5
	mfhi $t8
	beq $t8 0 eq		#if x=0 increment y by 1
	addi $t3 $t3 4
	beq $t3 $t2 fend
	b focc
eq:	
	addi $s4 $s4 1
	addi $t3 $t3 4
	beq $t3 $t2 fend
	b focc
fend:
	la $a0 0($s4) 
	li $v0 1		#syscall for read integer is 5
	syscall
quit:
	la $a0 term
	li $v0 4
	syscall
	b menu