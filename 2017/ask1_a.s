# Γέροντας Αλέξανδρος 321/2015029

# Δήλωση μεταβλητών
.data 
	msg0: .asciiz "Gerontas Alexandros \n" # Δήλωση του msg0
	msg1: .asciiz "321/2015029 \n" # Δήλωση του msg1

# Το πρόγραμμα τοποθετείται κάτω απο το .text
.text

# Κυρίως πρόγραμμα 
main: 
	la $a0,msg0 # Αποθήκευση διεύθυνσης msg0 στο καταχωρητή a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
			
	la $a0,msg1 # Αποθήκευση διεύθυνσης msg1 στο καταχωρητή a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση	
			
	li $v0,10 # Κλήση για έξοδο
	syscall # Εκτέλεση
