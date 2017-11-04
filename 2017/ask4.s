
.data

	array: .word 0:20
	i: .word 1	
	
	space: .asciiz " " # enter
	
	msg0: .asciiz "Dose ton 1o arithmo: " # Δήλωση του msg0
	msg1: .asciiz "Dose ton 2o arithmo: " # Δήλωση του msg1	

.text

main:

	lw $t3, i
	
	add $t3, $zero , $zero
	
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
	
	la $t2, array 
	sw $t1, ($t2)
	
	jal loop_
		
	add $t3, $0, $0 # i =0;
#	jal print
	
	jal end
	
end:
		li $v0,10 # Κλήση για έξοδο
		syscall # Εκτέλεση
		
loop_:
	add $t0, $t0, $t1 
	
	add $t3, $t3, 4  # i = i + 4
	
	add $t2, $t2, $t3
	
	sw $t0, ($t2)
	
	blt $t3,76,loop
	
	jr $ra
	
loop:
	add $t0, $t0, $t1 
	
	add $t3, $t3, 4  # i = i + 4
	
	add $t2, $t2, $t3
	
	sw $t0, ($t2)
	
	blt $t3,76,loop
	
	jr $ra
	
print :
	la $t2, array + 0($t3)
	
#	add $t2, $t2, $t3
	
	move $a0,$t2 # τυπωση αποτελεσματος
	li $v0,1
	syscall
	
	la $a0,space
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
	
	add $t3, $t3, 4
	
	blt $t3,76,loop
	
	jr $ra
  
  ﻿# Γέροντας Αλέξανδρος 321/2015029

# kalitera na apothikeusoume apetheias mesa ston pinaka
# to $t3 midenizetai me patenta
# to i einai axristo

t0 : o arithmos pou dinei o xristis
t1 : to bima tis proodou
t2 : apothikeueai i dieuthinsi mias seiras tou pinaka
t3 : (i) to keli tou pinaka pou theloume
	
