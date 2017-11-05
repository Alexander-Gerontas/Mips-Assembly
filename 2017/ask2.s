# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης 321/2015207
# Ζιώζας Γεώργιος 321/2015058

# Δήλωση μεταβλητών
.data 	
	# Δήλωση των μηνυμάτων που θα τυπωθούν.	
	space: .asciiz " " 
	msg0: .asciiz "Dose to plithos ton oron pou theleis na tipothoun: "
	msg1: .asciiz "Apotelesma: " 		 

# Το πρόγραμμα τοποθετείται κάτω απο το .text
.text

# Κυρίως πρόγραμμα 
main:         
        # Καθώς δεν μπορούμε να θέσουμε δικά μας ονόματα στις μεταβλητές τα σημειώνουμε στα σχόλια
        move   $t0, $0 # Prev : Kαταχωρητής για την αποθήκευση του fib_n
        li     $t1, 1  # Next : Kαταχωρητής για την αποθήκευση του fib_n+1
        move   $t2, $0 # Result : Kαταχωρητής για την αποθήκευση τελικού αποτελέσματος 
        move   $t3, $0 # Loop : Kαταχωρητής για την μέτρηση των επαναλήψεων του βρόνχου
                
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

	move $t0,$t1 # $t0 = $t1 --> prev = next 
	move $t1,$t2 # $t1 = $t2 --> next = result
	add $t2,$t0,$t1 # $t2 = $t0 + $t1 --> result = prev + next
	add $t3,$t3,1 # $t3 = $t3 + 1 --> loop += 1
	
	blt $t3,$t4,fib_loop # go to fib_loop if $t3 < $t4
	
	jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
