#Γέροντας Αλέξανδρος 321/2015029

# Δήλωση μεταβλητών
.data 
	msg0: .asciiz "Dose ton proto arithmo: " # Δήλωση του str1
	msg1: .asciiz "Dose ton deutero arithmo: " # Δήλωση του str2
	msg2: .asciiz "Apotelesma: "

# Το πρόγραμμα τοποθετείται κάτω απο το.text
.text

# Κυρίως πρόγραμμα 
main: 
	la $a0,msg0
	li $v0,4 	
	syscall # Εκτέλεση
	
	li $v0,5 
	syscall # Εκτέλεση	
	
	move $t0,$v0 
		
	la $a0,msg1
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση

	li $v0, 5 # Κλήση για διάβασμα ακεραίου
	syscall # Εκτέλεση	

	move $t1,$v0 # Αποθήκευση της τιμής στον καταχωρητή t1	

	sub $s0, $t0, $t1 #Εκτέλεση της πράξης αφαίρεσης 
	
	la $a0,msg2
	li $v0,4 	
	syscall # Εκτέλεση
	
	li $v0,1 	
	move $a0,$s0 # Αποθήκευση της τιμής του s0 στον καταχωρητή a0
	syscall # Εκτέλεση
	
	li $v0,10 # Κλήση για έξοδο
	syscall # Εκτέλεση
