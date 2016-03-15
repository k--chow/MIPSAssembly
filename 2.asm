.data
	a:		.space 80
	numb:		.word 0


.text
 	.globl main
 	main:
 		addi $t0, $zero, 17 	#$t0 is 17
 		sw $t0, numb  		#b is now 17

 		la $s0, a 			#load base of array into $s0

 	loop:
 		#check condition, if success continue, else exit

 		slti $t1, $t0, 22
 		beq $t1, $zero, exit


 		li $v0, 1		#test for value of b
 		lw $a0, numb
 		syscall

 		srl $t2, $t0, 1 	#b/2
 		mul $t3, $t0, 13	#b * 13
 		sll $t4, $t2, 2
 		add $t4, $t4, $s0
 		sw $t3, 0($t4)		#a[b/2] <- b*13

 		li $v0, 1		# test for value of b*13
 		lw $a0, 0($t4)
 		syscall

 		addi $t0, $t0, 1
 		sw $t0, numb		#numb++
 		j loop



 	exit:
 		li $v0, 10
 		syscall
