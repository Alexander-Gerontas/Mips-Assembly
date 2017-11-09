# Γέροντας Αλέξανδρος 321/2015029

.data 	

	enter: .asciiz "\n\n" # enter
	msg0: .asciiz "Calculation of the Greatest Common Divis or of two integers using Euclid's algorithm \n"
	msg1: .asciiz "Dose ton 1o arithmo: " 
	msg2: .asciiz "Dose ton 2o arithmo: " 
	msg3: .asciiz "The Greatest Common Divisor is: "
	msg4: .asciiz "Both numbers are 0s!!! \n"

.text
	# Κυρίως πρόγραμμα 
	main:
		la $a0,msg0 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0,4    # Κλήση για εκτέλεση εκτύπωσης string	
		syscall     # Εκτέλεση
		
		move $t2,$0 # H μεταβλητή loop είναι ο μετρητής επαναλήψεων του βρόνχου
		j loop # Μεταφέρουμε την εκτέλεση στη συνάρτηση loop χωρίς να αποθηκεύσουμε τον μετρητή του προγράμματος
	
	
	loop:		
		add $t2, $t2, 1
		beq $t2,3,exit
		
		jal give_numbers
						
		bltz $t0,check_if_t0_negative
		bltz $t1,check_if_t1_negative
		
		jal check_all
		
		jal euclid_loop
		
		jal print_result	
		
	give_numbers: 
		# Τυπώνουμε μήνυμα στον χρήστη για να εισάγει τον 1ο αριθμό
		la $a0,msg1 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0
		li $v0,4
		syscall # Εκτέλεση
		
		li $v0,5   
		syscall # Εκτέλεση
		move $t0,$v0 
		
		la $a0,msg2  #ζηταμε απο τον χρηστη τον 2ο αριθμο
		li $v0,4
		syscall # Εκτέλεση
		
		li $v0,5  # μεταφορα ακεραιου στον $t1 
		syscall 
		move $t1,$v0 
		
		jr $ra 	
		
	check_if_t0_negative:						
		sub $t0, $0, $t0 # 
		jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
				
	check_if_t1_negative:		
		sub $t1, $0, $t1		
		jr $ra

	check_all: # αλλαγη ονοματος
		bnez $t0,if_t0_not_zero # if num0 != 0			
		bnez $t1,if_t1_not_zero # if num1 != 0
		
		la $a0,msg4 # τυπωση msg4
		li $v0,4 
		syscall # Εκτέλεση
		
		j loop
			
	if_t0_not_zero:
		bnez $t1, return
		j print_result
		
	if_t1_not_zero:
		move $t0,$t1
		j print_result
				
	return: 
		jr $ra		
		
	euclid_loop:		
		div $t0, $t1
		move $t0,$t1
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
		
		la $a0,enter
		li $v0,4 
		syscall 
		
		j loop
		
	
	
	exit:
		li $v0,10 # Κλήση για έξοδο
		syscall # Εκτέλεση
