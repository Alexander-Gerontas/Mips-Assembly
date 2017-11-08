# Γέροντας Αλέξανδρος 321/2015029

.data 	

	loop: .word 0 # H μεταβλητή loop είναι ο μετρητής επαναλήψεων του βρόνχου

	space: .asciiz "\n\n" # enter

	msg0: .asciiz "Calculation of the Greatest Common Divis or of two integers using Euclid's algorithm \n"
	msg1: .asciiz "Dose ton 1o arithmo: " 
	msg2: .asciiz "Dose ton 2o arithmo: " 
	msg3: .asciiz "The Greatest Common Divisor is: "
	msg4: .asciiz "Both numbers are 0s!!! \n"

.text
	main:
		la $a0,msg0  # tiposi arxikou minimatos
		li $v0,4
		syscall 
		
		jal give_numbers
		
		jal check_if_zero
		jal check_if_negative
		
		jal euclid_loop
		
		jal print_result
		
		j exit
		
	check_if_zero:	
		bnez $t1, return # if t1 not zero
		beq $t1, $t2 
		
	return 
		jr $ra
		
		
	euclid_loop:		
		div $t0, $t1
		add $t0,$t1,0 # patenta
		mfhi $t1

		bne $t1,0,euclid_loop
	
		jr $ra 
		
	print_result:
		la $a0,msg3 # τυπωση msg3 
		li $v0,4 
		syscall 		
		
		move $a0,$t0 # τυπωση αποτελεσματος
		li $v0,1
		syscall
		
		la $a0,space
		li $v0,4 
		syscall 
		
		jr $ra 
		
	give_numbers: 
		la $a0,msg1  # ζηταμε απο τον χρηστη 1 αριθμο
		li $v0,4
		syscall
		
		li $v0,5   
		syscall 
		move $t0,$v0 
		
		la $a0,msg2  #ζηταμε απο τον χρηστη τον 2ο αριθμο
		li $v0,4
		syscall
		
		li $v0,5  # μεταφορα ακεραιου στον $t1 
		syscall 
		move $t1,$v0 
		
		jr $ra 	
	
	exit:
		li $v0,10 
		syscall 
