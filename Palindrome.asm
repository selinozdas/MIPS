
.data
mem:.space 1024
ip: .asciiz "A Palindrome"
np: .asciiz "Not A Palindrome"
.text
#read user input
li $v0 8
la $a0 mem
li $a1 1024
syscall

charnu: 
	add $t2 $a0, $t0 
	lb $t2 0($t2) 
	addi $t0 $t0 1
	bne $t2 $0 charnu 
	
done:
	addi $t7 $t0 -3
 	addi $t0 $t0 -2 

for:	
	add $t2, $a0, $t1 
	lb $t4, 0($t2) 
 	add $t3, $a0, $t7 
 	lb $t5, 0($t3) 
 	bne $t4, $t5, notPal
	addi $t7, $t7, -1 
 	addi $t1, $t1, 1 
 	slt $t2 $t1 $t7
	bne $t2 $0 for
 	addi $t1, $0, 0 

isPal: 
	la $a0 ip
	li $v0 4
	syscall
	j end

notPal:
	la $a0 np
	li $v0 4
	syscall
end:
