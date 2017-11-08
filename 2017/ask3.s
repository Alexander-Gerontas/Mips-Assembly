# Γέροντας Αλέξανδρος 321/2015029

.data 	

	#loop: .word 0 # H μεταβλητή loop είναι ο μετρητής επαναλήψεων του βρόνχου

	enter: .asciiz "\n\n" # enter

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
		
		add $t2, $0, 0
		j loop
	
	loop:		
		add $t2, $t2, 1
		beq $t2,3,exit
		
		jal give_numbers
				
#		jal check_if_zero 
		jal check_if_negative
		jal check_all
		
		jal euclid_loop
		
		jal print_result
		
		j loop # to print kalei to loop opote afto dn xreiazetai

	check_if_negative:
		bgez $t0,check_if_t1_negative
		sub $t0, $0, $t0
		
		j check_if_t1_negative
		
		
	check_if_t1_negative:
		bgez $t1,return
		sub $t1,$0, $t1
		
		j return 

	check_all:
		bnez $t0,else # if num0 != 0
			
		bnez $t1,else_2 # if num1 != 0
		
		la $a0,msg4 # τυπωση msg4
		li $v0,4 
		syscall 
		
		j loop
			
	else:
		bnez $t1,return
		move $t4,$t0
		j print_result
		
	else_2:
		move $t4,$t1
		j print_result
				
		
	return: 
		jr $ra		
		
	euclid_loop:		
		div $t0, $t1
		add $t0,$t1,0 # patenta
		mfhi $t1
				
		bne $t1,0,euclid_loop
		
		move $t4, $t0
	
		jr $ra 
		
	print_result:
		la $a0,msg3 # τυπωση msg3 
		li $v0,4 
		syscall 		
		
		move $a0,$t4 # τυπωση αποτελεσματος
		li $v0,1
		syscall
		
		la $a0,enter
		li $v0,4 
		syscall 
		
		j loop
		
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
