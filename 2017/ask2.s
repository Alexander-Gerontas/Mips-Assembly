# Γέροντας Αλέξανδρος 321/2015029

# Δήλωση μεταβλητών
.data 	
	prev: .word 0 # Μεταβλητή για την αποθήκευση του fib_n
	next: .word 1 # Μεταβλητή για την αποθήκευση του fib_n+1
	result: .word 0	# Μεταβλητή για την Aποθήκευση τελικού αποτελέσματος 
	loop: .word 0 # H μεταβλητή loop είναι ο μετρητής επαναλήψεων του βρόνχου
	
	space: .asciiz " " # Δήλωση μηνυμάτων
	msg0: .asciiz "Dose to plithos ton oron pou theleis na tipothoun: "
	msg1: .asciiz "Apotelesma: " 		 

# Το πρόγραμμα τοποθετείται κάτω απο το .text
.text

# Κυρίως πρόγραμμα 
main: 
	lw $t0, prev # Φόρτωση τιμών των μεταβλητών στους καταχωρητές $t0,$t1,$t2 και $t3. 
	lw $t1, next
        lw $t2, result
        lw $t3, loop
                
        la $a0,msg0 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση
        
        li $v0,5 # Κλήση για διάβασμα ακεραίου  
	syscall # Εκτέλεση
	move $t4,$v0 # Αποθήκευση της τιμής στον καταχωρητή $t4
        
        la $a0,msg1 # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string
	syscall # Εκτέλεση
        
	jal fib_loop # Κλήση της συνάρτησης fib_loop
	
	li $v0,10 # Κλήση για έξοδο
	syscall # Εκτέλεση

# Συνάρτηση για τον υπολογισμό της ακολουθίας Fibonacci		
fib_loop:
	move $a0,$t2 # Αποθήκευση διεύθυνσης $t2 στον καταχωρητή $a0 
	li $v0,1 # Κλήση για εκτέλεση εκτύπωσης ακεραίου
	syscall # Εκτέλεση
	
	la $a0,space # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0 
	li $v0,4 # Κλήση για εκτέλεση εκτύπωσης string	
	syscall # Εκτέλεση

	add $t0,$t1,0 # $t0 = $t1 + 0 --> prev = next + 1
	add $t1,$t2,0 # $t1 = $t2 + 0 --> next = result + 0
	add $t2,$t0,$t1 # $t2 = $t0 + $t1 --> result = prev + next
	add $t3,$t3,1 # $t3 = $t3 + 1 --> loop += 1
	
	blt $t3,$t4,fib_loop # go to fib_loop if $t3 > $t4
	
	jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra