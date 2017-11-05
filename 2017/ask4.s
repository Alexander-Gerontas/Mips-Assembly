.data

	#array: .space 80
	
	array: .word 0:20
	
	#i: .word 1	
	
	space: .asciiz " " # enter
	
	msg0: .asciiz "Dose ton 1o arithmo: " # Δήλωση του msg0
	msg1: .asciiz "Dose ton 2o arithmo: " # Δήλωση του msg1	

.text

main:	
	la $a0,msg0 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	li $v0,5 # Κλήση για διάβασμα ακεραίου  
	syscall # Εκτέλεση
	move $t0,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
	
	la $a0,msg1 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	li $v0,5 # Κλήση για διάβασμα ακεραίου  
	syscall # Εκτέλεση
	move $t1,$v0 # Αποθήκευση της τιμής στον καταχωρητή 
		
	add $t3, $zero , $zero
	
	jal loop
	
	la $t2, array 
	
	add $t3, $zero , $zero
	add $t2, $0 , $0
	
	jal print	
		
	jal end
	 
loop :
	la $t2, array($t3)
	
	sw $t0, ($t2)
		
	add $t0,$t0,$t1
	add $t3,$t3,4
	
	blt $t3, 80, loop 
	
	jr $ra
	 
print :		
	lw $t2, array($t3)
	
	move $a0,$t2 # τυπωση αποτελεσματος
	li $v0,1
	syscall

	la $a0,space
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	add $t3, $t3, 4 # i = i + 4
	
	blt $t3,80,print
	
	jr $ra
	
end:
	li $v0,10 # Κλήση για έξοδο
	syscall # Εκτέλεση
	
