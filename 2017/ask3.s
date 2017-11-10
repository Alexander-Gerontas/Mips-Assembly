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
		
		move $t2,$0 # Μηδενίζουμε την μεταβλητή $t2 η οποία είναι ο μετρητής επαναλήψεων του βρόνχου
		j loop      # Μεταφέρουμε την εκτέλεση στη συνάρτηση loop χωρίς να αποθηκεύσουμε τον μετρητή του προγράμματος
	
	
	loop:		
		add $t2, $t2, 1   # $t2 = $t2 + 1
		beq $t2,3,exit    # Aν $t2 = 3 κάνε άλμα στο exit
		
		jal give_numbers # Μεταφέρουμε την εκτέλεση στη συνάρτηση give_numbers και αποθηκεύουμε τον μετρητή του προγράμματος
						
		bltz $t0,if_t0_negative
		bltz $t1,if_t1_negative
		
		jal check_all
		
		jal euclid_loop
		
		jal print_result	
		
	# Εισαγωγή αριθμών από τον χρήστη
	give_numbers:
		# Τυπώνουμε μήνυμα στον χρήστη για να εισάγει τον 1ο αριθμό
		la $a0,msg1  # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0
		li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
		syscall      # Εκτέλεση
		
		li $v0,5     # Κλήση για διάβασμα ακεραίου  
		syscall      # Εκτέλεση
		move $t0,$v0 # Αποθήκευση της τιμής στον καταχωρητή $t0
		
		# Στη συνέχεια ζητάμε απο τον χρήστη να εισάγει και τον 2ο αριθμό
		la $a0,msg2  # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0
		li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string
		syscall      # Εκτέλεση
		
		li $v0,5     # Κλήση για διάβασμα ακεραίου 
		syscall      # Εκτέλεση
		move $t1,$v0 # Αποθήκευση της τιμής στον καταχωρητή $t1
		
		jr $ra 	
		
	if_t0_negative:						
		sub $t0, $0, $t0 # Αφαιρούμε τον καταχωρητή $t0 από το 0 για να τον μετατρέψουμε σε θετικό
		jr $ra           # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
				
	if_t1_negative:		
		sub $t1, $0, $t1 # Αφαιρούμε τον καταχωρητή $t1 από το 0 για να τον μετατρέψουμε σε θετικό		
		jr $ra           # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra

	check_all: # αλλαγη ονοματος
		bnez $t0,if_t0_not_zero # if num0 != 0			
		bnez $t1,if_t1_not_zero # if num1 != 0
		
		# Αν και οι 2 αριθμοί είναι ίσοι με το μηδέν τυπώνουμε το αντίστοιχο μήνυμα
		la $a0,msg4 # Αποθήκευση διεύθυνσης msg4 στον καταχωρητή $a0 
		li $v0,4    # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
		syscall     # Εκτέλεση
		
		j loop      # Άλμα στην συνάρτηση loop
			
	if_t0_not_zero:
		bnez $t1, return
		j print_result # Άλμα στην συνάρτηση print_result
		
	if_t1_not_zero:
		move $t0,$t1   # t0 = t1 
		j print_result # Άλμα στην συνάρτηση print_result
				
	return: 
		jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra	
		
	euclid_loop:		
		div $t0, $t1
		move $t0,$t1
		mfhi $t1
				
		bne $t1,0,euclid_loop	
			
		jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	# Τύπωση αποτελέσματος
	print_result:
		la $a0,msg3   # Αποθήκευση διεύθυνσης msg3 στον καταχωρητή $a0 
		li $v0,4      # Κλήση για εκτέλεση εκτύπωσης string
		syscall       # Εκτέλεση		
		
		move $a0,$t0  # Αποθήκευση την τιμή του καταχωρητή $t0 στον καταχωρητή $a0 
		li $v0,1      # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall       # Εκτέλεση
		
		la $a0, enter # Αποθήκευση διεύθυνσης enter στον καταχωρητή $a0 
		li $v0,4      # Κλήση για εκτέλεση εκτύπωσης string
		syscall       # Εκτέλεση 
		
		j loop        # Άλμα στην συνάρτηση loop
		
	exit:
		li $v0,10 # Κλήση για έξοδο
		syscall   # Εκτέλεση
