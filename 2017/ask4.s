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
	move $t0,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
	
	la $a0,msg1  # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
	li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
	syscall      # Εκτέλεση
	
	li $v0,5     # Κλήση για διάβασμα ακεραίου  
	syscall      # Εκτέλεση
	move $t1,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
		
	li $s0, 0
	li $s1, 0 
	
	jal loop         # gemisma pinaka
	
	sw $s1, arraySum # Αποθήκευση τιμής του καταχωρητή $s1 στην μεταβλητή arraySum
	
	la $t2, array 
	
	li $s0, 76	
	
	jal print_R	
	
	li $s0, 0
			
	jal end
	 
loop :
	la $t2, array($s0)

	sw $t0, ($t2)
		
	add $s1, $s1, $t0	
		
	add $t0,$t0,$t1
	add $s0,$s0,4

	blt $s0, 80, loop 
		
	jr $ra
	
print_R :		
	lw $t2, array($s0)
	
	move $a0,$t2 # τυπωση αποτελεσματος
	li $v0,1
	syscall

	la $a0,space # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0 
	li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
	syscall      # Εκτέλεση
	
	add $s0, $s0, -4 # i = i - 4
	
	bgez $s0, print_R
	
	la $a0,msg2 # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
	li $v0,4    # Κλήση για εκτέλεση εκτύπωσης string	
	syscall     # Εκτέλεση
	
	lw $a0,arraySum	
	li $v0,1
	syscall	
	
	jr $ra
		
end:
	li $v0,10 # Κλήση για έξοδο
	syscall # Εκτέλεση
	
