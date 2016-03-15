.data
	a:		.space 140
	numb:		.word 0


.text
 	.globl main
 	main:
 		addi $t0, $zero, 2	#$t0 is i
 		la $s0, a 			#load base of array into $s0
 		#store base cases
 		addi $t1, $zero, 1    #$t1 is 1
 		addi $t2, $t1, 1	  #$t2 is 2
 		#store base case 1
 		sll $t4, $zero, 2
 		add $t4, $t4, $s0
 		sw  $t1, 0($t4)
 		#store base case 2
 		sll $t4, $t1, 2
 		add $t4, $t4, $s0
 		sw  $t2, 0($t4)

 	loop:
 		#i is 2 to 34 inclusive, therefore less than 35
 		slti $t3, $t0, 7	#if i < 35
 		beq  $t3, $zero, exit

 		#i is between 2 and 34 inclusive get the grumpy number
 		addi $t2, $t0, -1            #$t2 is i-1
 		sll $t4, $t2, 2			     #G(i-1) address
 		add $t4, $t4, $s0			
 		lw  $t3, 0($t4)
 		addi $t3, $t3, -2			 #-2 to get the right power, idk why
 		addi $t1, $zero, 2			 #t1 is 2
 		sll $t1, $t1, $t3			 # 2^ G(i-1)
 		mul $t1, $t1, 2

 		addi $t6, $zero, 3			 #$t6 is 3
 		addi $t7, $t2, -1			 #t7 is i-2
 		sll $t4, $t7, 2				 #get G(i-2)
 		add $t4, $t4, $s0			 #G(i-2) address
 		lw  $t3, 0($t4)				 #$t3 is G(i-2)
 		mul $t3, $t3, 3				 #G(i-2) * 3
 		add $t1, $t1, $t3			 #2^G(i-1) + (3*G(i-2))

 		
 		mfhi $t2					 # load hi into $t2
 		bne $t2, $zero, exit		 #if hi is anything but 0, 
 		sw	$t1, numb 				 # $t1

 		#store into array!

 		sll $t4, $t0, 2
 		add $t4, $t4, $s0
 		sw  $t1, 0($t4)	  #G[i] <- numb

 		li $v0, 1
 		lw $a0, numb
 		syscall

 		#increment i
 		addi $t0, $t0, 1

 		j loop


 		


 	exit:
 		li $v0, 10
 		syscall
