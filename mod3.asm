.data
num: .asciiz "enter number:"
z: .asciiz "Result is zero"
o:.asciiz "Result is one"
t: .asciiz "Result is two"
.text
   	la $a0 num		#syscall fill
    	li $v0 4		
    	syscall		
    	li $v0 5		
    	syscall		
    	addi $t2 $v0 0	#store input word
    	sll $t1 $t2 1
    	add $t1 $t1 4
    	sra $t1 $t1 1
    	add $t1 $t1 -1
for:	sub $t1 $t1 3 
    	beq $t1 1 zero
    	beq $t1 0 two
    	beq $t1 2 one
    	b for
    	
zero:	la $a0 z		#syscall fill
    	li $v0 4		
    	syscall	
    	b end
one:	la $a0 o		#syscall fill
    	li $v0 4		
    	syscall
    	b end
two:	la $a0 t		#syscall fill
    	li $v0 4		
    	syscall
end: