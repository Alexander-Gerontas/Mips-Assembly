# Γέροντας Αλέξανδρος 321/2015029

# Δήλωση μεταβλητών
.data 	
	prev: .word 0
	next: .word 1
	result: .word 0
	
	loop: .word 0 # prosorini metabliti prepei na figei
	
	msg0: .asciiz "Apotelesma: " # Δήλωση του msg0
	msg1: .asciiz " " # Δήλωση του msg0	
	msg3: .asciiz "Dose to plithos ton oron pou theleis na tipothoun: " # Δήλωση του msg0

# Το πρόγραμμα τοποθετείται κάτω απο το .text
.text

# Κυρίως πρόγραμμα 
main: 
	lw $t0, prev # ekxorisi metabliton stous deiktes
	lw $t1, next
        lw $t2, result
        lw $t3, loop
                
        la $a0,msg3 # Αποθήκευση διεύθυνσης msg0 στο καταχωρητή a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
        
        li $v0,5 # Κλήση για διάβασμα ακεραίου  
	syscall # Εκτέλεση		
	move $t4,$v0 # Αποθήκευση της τιμής στον καταχωρητή t4
        
        la $a0,msg0 # Αποθήκευση διεύθυνσης msg0 στο καταχωρητή a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
        
	#jal fib_loop # ekkinisi bronxou
	 		
fib_loop:	

	move $a0,$t2 # Αποθήκευση της τιμής του t0 στον καταχωρητή a0	
	li $v0,1 # Κλήση για εκτέλεση εκτύπωσης int 	
	syscall # Εκτέλεση
	
	la $a0,msg1 # Αποθήκευση διεύθυνσης msg0 στο καταχωρητή a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση

	add $t0,$t1,0 # prev = next;
	add $t1,$t2,0  # next = result;
	add $t2,$t0,$t1 # result = next + prev;
	add $t3,$t3,1
	
	blt $t3,$t4,fib_loop
	
	li $v0,10
	syscall
