# Γέροντας Αλέξανδρος 321/2015029

# Δήλωση μεταβλητών
.data 	
	#result: .word 0	# Μεταβλητή για την Aποθήκευση τελικού αποτελέσματος 
	loop: .word 0 # H μεταβλητή loop είναι ο μετρητής επαναλήψεων του βρόνχου
		
	msg0: .asciiz "Calculation of the Greatest Common Divis or of two integers using Euclid's algorithm\n"

	msg1: .asciiz "Dose ton 1o arithmo: " # Δήλωση του msg0
	msg2: .asciiz "Dose ton 2o arithmo: " # Δήλωση του msg1	 
	
	msg3: .asciiz "The Greatest Common Divisor is: "
	
	msg4: .asciiz "Both numbers are 0s!!! \n"

	enter: .asciiz "\n" # Δήλωση του msg1

# Το πρόγραμμα τοποθετείται κάτω απο το .text
.text

# Κυρίως πρόγραμμα 
main:          
        la $a0,msg0 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	la $a0,msg1 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
        
        li $v0,5 # Κλήση για διάβασμα ακεραίου  
	syscall # Εκτέλεση
	move $t0,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
	
	la $a0,msg1 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
        
        li $v0,5 # Κλήση για διάβασμα ακεραίου  
	syscall # Εκτέλεση
	move $t1,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
        
        # if num0 && num1 == 0
        
        bne $t0, $t1, ELSE # cond1: branch if ! (num1  == num2 ) 
        bne $t0, 0 , ELSE  
        la $a0,msg4 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση 
        
        jal END
        
        ELSE:
		jal euclid_loop # Κλήση της συνάρτησης 
	
		la $a0,msg3 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
		syscall # Εκτέλεση
	
		move $a0,$t0 # Αποθήκευση διεύθυνσης $t2 στον καταχωρητή $a0 
		li $v0,1 # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall # Εκτέλεση
	
	END:
		li $v0,10 # Κλήση για έξοδο
		syscall # Εκτέλεση
	
euclid_loop:

	add $t2,$t0,0
	add $t0,$t1,0
	rem $t1,$t2,$t1	

	bne $t1,0,euclid_loop
	
	jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
