# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	space: .asciiz " " 
	enter: .asciiz "\n" 
	
	msg0: .asciiz "Dose to k: "
	
	temp: .word 100
	k:    .word 0
	
.text

	Main:	
	
		lw $t9, temp
		jal fill
	
		li $s1, 0      # $s1 = 0
		jal Print      # Τύπωση μη ταξινομημένου πίνακα
	
		jal GetNumber
	
		li $v0, 10   # Κλήση για έξοδο
		syscall      # Εκτέλεση
		
	Calc:
		
		
	# Είσοδος αριθμών από τον χρήστη
	GetNumber:	
		la $a0, msg0            # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		li $v0,5                # Κλήση για διάβασμα ακεραίου  
		syscall                 # Εκτέλεση	
		sw $v0, k
			
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
