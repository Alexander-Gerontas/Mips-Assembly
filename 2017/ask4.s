# Γέροντας Αλέξανδρος 321/2015029

.data	
	array: .word 0:20
		
	arraySum: .word 0 # Άθροισμα όρων ακολουθίας
	
	space: .asciiz " " # enter
		
	msg0: .asciiz "Dose ton 1o arithmo: " # Δήλωση του msg0
	msg1: .asciiz "Dose ton 2o arithmo: " # Δήλωση του msg1		
	msg2: .asciiz "\nThe sum of the 20 first terms of the sequence is: "
  
.text

main:	
	la $a0,msg0  # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
	syscall      # Εκτέλεση
	
	li $v0,5     # Κλήση για διάβασμα ακεραίου  
	syscall      # Εκτέλεση
	move $s0,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
	
	la $a0,msg1  # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
	li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
	syscall      # Εκτέλεση
	
	li $v0,5     # Κλήση για διάβασμα ακεραίου  
	syscall      # Εκτέλεση
	move $s1,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
		
	li $s2, 0    # O $s2 ειναι ο μετρητης της επαναληψης o οποιος χρησιμοποιειται και για την διασχηση του πινακα
	li $s3, 0    # Ο καταχωρητης $s3 χρησιμοποιειται gia to υπολογισμο του Άθροισμα όρων ακολουθίας
	
	jal Array_Loop         # Άλμα στην συνάρτηση Array_Loop
	
	sw $s3, arraySum # Αποθήκευση τιμής του καταχωρητή $s3 στην μεταβλητή arraySum
	
	la $t2, array 

	li $s2, 76	
	
	jal print_R	# Άλμα στην συνάρτηση Array_Loop
			
	jal end      # Άλμα στην συνάρτηση end
	 
Array_Loop :
	la $t0, array($s2)

	sw $s0, ($t0)
		
	add $s3, $s3, $s0	
		
	add $s0, $s0, $s1
	addi $s2, $s2, 4

	blt $s2, 80, Array_Loop 
		
	jr $ra
	
print_R :		
	lw $t0, array($s2)
	
	move $a0,$t0 # τυπωση αποτελεσματος
	li $v0,1
	syscall

	la $a0,space # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0 
	li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
	syscall      # Εκτέλεση
	
	addi $s2, $s2, -4 # i = i - 4
	
	bgez $s2, print_R
	
	la $a0,msg2 # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
	li $v0,4    # Κλήση για εκτέλεση εκτύπωσης string	
	syscall     # Εκτέλεση
	
	lw $a0,arraySum	
	li $v0,1
	syscall	
	
	jr $ra
		
end:
	li $v0,10 # Κλήση για έξοδο
	syscall   # Εκτέλεση
	
