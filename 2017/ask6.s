# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	space: .asciiz " " 
	enter: .asciiz "\n" 
	
	temp: .word 100
	
.text

	Main:	
	
		lw $t9, temp
		jal fill
	
		li $s1, 0      # $s1 = 0
		jal Print      # Τύπωση μη ταξινομημένου πίνακα
	
		li $v0, 10   # Κλήση για έξοδο
		syscall      # Εκτέλεση
		
	# Είσοδος αριθμών από τον χρήστη
	GetNumbers:
		la $s2, array($s1)      # Αποθήκευση της διεύθυνσης του πίνακα στη θέση $s1 στον καταχωρητή $s2
		
		#la $a0, msg2            # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		#syscall                 # Εκτέλεση
		
		#move $a0, $s0           # Αποθήκευση της τιμής του καταχωρητή $s0 στον καταχωρητή $a0 
		li $v0, 1               # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		#syscall                 # Εκτέλεση
		
		#la $a0, msg3            # Αποθήκευση διεύθυνσης msg3 στον καταχωρητή $a0 
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		li $v0,5                # Κλήση για διάβασμα ακεραίου  
		#syscall                 # Εκτέλεση	
		sw $v0, ($s2)           # Αποθήκευση της τιμής στην θέση $s1 του πίνακα
			
		add $s1, $s1, 4         # $s1 = $s1 + 4
		add $s0, $s0, 1         # $s0 = $s0 + 1
	
		blt $s1, 40, GetNumbers # if $s1 < 40 goto GetNumbers
				
		jr $ra                  # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
	
	# Εκτυπώνει τους όρους του πίνακα στη σειρά 		
	Print:	
		lw $s3, array($s1) # Αποθήκευση της τιμής του πίνακα στη θέση $s1 στον καταχωρητή $s3
	
		move $a0, $s3      # Αποθήκευση της τιμής του καταχωρητή $s3 στον καταχωρητή $a0 
		li $v0, 1          # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall            # Εκτέλεση

		la $a0, space      # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string
		syscall            # Εκτέλεση
	
		add $s1, $s1, 4	   # $s1 = s1 + 4
		blt $s1, 40, Print # if $s1 < 40 goto Print
		
		la $a0, enter      # Αποθήκευση διεύθυνσης enter στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string	
		syscall            # Εκτέλεση
	
		jr $ra             # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra
	
	


# γεμισμα του πινακα με δικες μου τιμες						
fill:

		la $s3, array($s1)
	
		sw $t9, ($s3)
		
		add $t9,$t9,-10		
		
		add $s1,$s1,4
	
		blt $s1, 40, fill 
				
		jr $ra
