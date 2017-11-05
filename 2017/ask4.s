# Γέροντας Αλέξανδρος 321/2015029

# to $t3,$t4 midenizetai me patenta
# ti ennoei sto 5 metabliti stin kiria mnimi

#t0 : o arithmos pou dinei o xristis
#t1 : to bima tis proodou
#t2 : (array[0]) apothikeueai i dieuthinsi mias seiras tou pinaka
#t3 : (i) to keli tou pinaka pou theloume
#t4 : (arraySum)

.data	
	array: .word 0:20
		
	space: .asciiz " " # enter
	
	msg0: .asciiz "Dose ton 1o arithmo: " # Δήλωση του msg0
	msg1: .asciiz "Dose ton 2o arithmo: " # Δήλωση του msg1	
	
	msg2: .asciiz "\nThe sum of the 20  first terms of the sequence is: "
  
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
	add $t4, $0, 0
	
	jal loop
	
	la $t2, array 
	
	add $t3, $zero, 76	
	
	jal print_R	
	
	add $t3, $0, 0
			
	jal end
	 
loop :
	la $t2, array($t3)
	
	sw $t0, ($t2)
		
	add $t4, $t4, $t0	
		
	add $t0,$t0,$t1
	add $t3,$t3,4
	
	blt $t3, 80, loop 
		
	jr $ra
	
print_R :		
	lw $t2, array($t3)
	
	move $a0,$t2 # τυπωση αποτελεσματος
	li $v0,1
	syscall

	la $a0,space
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	add $t3, $t3, -4 # i = i - 4
	
	bgez $t3, print_R
	
	la $a0,msg2
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	move $a0,$t4 # τυπωση αποτελεσματος
	li $v0,1
	syscall	
	
	jr $ra
		
end:
	li $v0,10 # Κλήση για έξοδο
	syscall # Εκτέλεση
	
