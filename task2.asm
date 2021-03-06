	.data
str1:	.asciiz "\r\nSuccess! Location: "
str2:	.asciiz "\r\nFail!\r\n"
str3:	.asciiz "\r\n"
buffer:	.space 100

	.text
	.globl main
main:	
	# read the buffer
	la $a0, buffer
	la $a1, 100
	li $v0, 8
	syscall

	# read the char
input:  
	li $v0, 12
 	syscall
	# if char = ?, end the program
	beq $v0, '?', goend
 	la $s1, buffer
 	li $t0, 0

	# enter into the loop and try to find the same char
loop:  
	lb $s0, 0($s1)
	sub $t1, $v0, $s0
	beq $t1, $0, success
   	addi $t0, $t0, 1
	slt $t3, $t0, $a1
	beq $t3, $0, fail
	addi $s1 $s1, 1
	j loop

	# if find successfully
success:   
	la $a0, str1
	li $v0, 4
	syscall
	addi $a0, $t0, 1
 	li $v0, 1 
	syscall
	la $a0, str3
	li $v0, 4
	syscall
	j input

	# if there's no same char 
fail:       
	la $a0, str2
	li $v0, 4
 	syscall
	j input

	# end the program
goend:       
	li $v0, 10
	syscall
