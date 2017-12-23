# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	# Δήλωση μηνυμάτων που θα τυπωθούν στην κονσόλα		
	space: .asciiz " "  	
	msg0:  .asciiz "Give temperature "
	msg1:  .asciiz ": "
	msg2:  .asciiz "Enter number of years to calculate average temperature: "
	msg3:  .asciiz "K has to be between 0 and 10 \n"
	msg4:  .asciiz "Average temperatures per "
	msg5:  .asciiz " years: \n"
	
	k:         .word 0 # Μεταβλητή για την αποθήκευση του πλήθους των θερμοκρασιών
	ArrayPos:  .word 0 # Kρατάει την θέση του πίνακα όπου ξεκινάει ο επόμενος κινούμενος μέσος 
	EndPos:    .word 0 # Μεταβλητή για τον τερματισμό της συνάρτησης PrintMovingSum
	LoopCount: .word 1 # Μεταβλητή για την τύπωση του αριθμού της θερμοκρασίας που θα εισάγει ο χρήστης
	
.text
	# Κυρίως πρόγραμμα
	Main:			
		li $s0, 0            # $s0 = 0		
				
		jal GetTemperatures  # Άλμα στην συνάρτηση GetTemperatures			
		jal GetNumberOfYears # Άλμα στην συνάρτηση GetNumberOfYears
		lw $a1, k            # $a1 = k
						
		la $a0, msg4         # Αποθήκευση διεύθυνσης msg4 στον καταχωρητή $a0         
		li $v0, 4            # Κλήση για εκτέλεση εκτύπωσης string	
		syscall              # Εκτέλεση
		
		lw $a0, k            # $a0 = k	
		li $v0, 1            # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall              # Εκτέλεση
	
		la $a0, msg5         # Αποθήκευση διεύθυνσης msg5 στον καταχωρητή $a0
		li $v0, 4            # Κλήση για εκτέλεση εκτύπωσης string	
		syscall              # Εκτέλεση		
	
		# Τύπωση κινούμενων μέσων θερμοκρασιών										 
		PrintMovingSum:
			li $s1, 0                   # $s1 = 0
			lw $a0, ArrayPos            # $a0 = ArrayPos
			jal CalculateMovingSum 	    # Άλμα στην συνάρτηση CalculateMovingSum
						
			mov.s $f12, $f0	            # $f12 = $f0
			li $v0, 2                   # Κλήση για εκτέλεση εκτύπωσης float           
			syscall                     # Εκτέλεση
		
			la $a0, space               # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0
			li $v0, 4                   # Κλήση για εκτέλεση εκτύπωσης string	
			syscall                     # Εκτέλεση
												
			lw $s0, EndPos              # $s0 = EndPos		
			
			bne $s0, 40, PrintMovingSum # if $s0 < 40 goto PrintMovingSum			
		
		li $v0, 10           # Κλήση για έξοδο
		syscall              # Εκτέλεση
	
	# Υπολογισμός κινούμενων μέσων θερμοκρασιών
	CalculateMovingSum:
		lw $t0, array($a0)               # Αποθήκευση της διεύθυνσης του στοιχειού στην θέση $a0 του πίνακα στον καταχωρητή $t0
		
		add $s1, $s1, $t0                # $s1 = $s1 + $t0
		add $a0, $a0, 4                  # $a0 = $a0 + 4
						
		mul $t4, $a1, 4	                 # $t4 = $a1 * 4	
		lw $t5, ArrayPos                 # $t5 = ArrayPos
		add $t4, $t4, $t5                # $t4 = $t4 + $t5
			
		blt $a0, $t4, CalculateMovingSum # if $a0 < $t4 goto CalculateMovingSum
		
		sw $a0, EndPos                   # EndPos = $a0
		
		lw $t1, ArrayPos                 # $t1 = ArrayPos		
		add $t1, $t1, 4                  # $t1 = $t1 + 4	
		sw $t1, ArrayPos                 # ArrayPos = $t1
				
		mtc1 $s1, $f0                    # Μεταφορά του ακέραιου καταχωρητή $s1, στον καταχωρητή κινητής υποδιαστολής $f0
		cvt.s.w $f0, $f0                 # Μετατροπή της τιμής του καταχωρητή $f0 από ακέραιο σε κινητής υποδιαστολής
		
		mtc1 $a1, $f1                    # Μεταφορά του ακέραιου καταχωρητή $a1, στον καταχωρητή κινητής υποδιαστολής $f1
		cvt.s.w $f1, $f1                 # Μετατροπή της τιμής του καταχωρητή $f1 από ακέραιο σε κινητής υποδιαστολής
		
		div.s $f0, $f0, $f1              # $f0 = $f0 / $f1			
			
		jr $ra                           # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	# Είσοδος θερμοκρασιών από τον χρήστη
	GetTemperatures:
		la $t1, array($s0)           # Αποθήκευση της διεύθυνσης του στοιχειού στην θέση $t0 του πίνακα στον καταχωρητή $t1
		
		la $a0, msg0                 # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0, 4                    # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                      # Εκτέλεση
		
		lw $a0, LoopCount            # Φόρτωση της τιμής της μεταβλητής LoopCount στον καταχωρητή $a0
		li $v0, 1                    # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall                      # Εκτέλεση
		
		add $a0, $a0, 1              # $a0 = $a0 + 1
		sw $a0, LoopCount            # LoopCount = $a0
		
		la $a0, msg1                 # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0
		li $v0, 4                    # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                      # Εκτέλεση
		
		li $v0,5                     # Κλήση για διάβασμα ακεραίου  
		syscall                      # Εκτέλεση	
		sw $v0, ($t1)                # Το στοιχείο του πίνακα στην θέση $t1 παίρνει την τιμή του καταχωρητή $v0
			
		add $s0, $s0, 4              # $s0 = $s0 + 4      
	
		blt $s0, 40, GetTemperatures # if $s0 < 40 goto GetTemperatures
				
		jr $ra                       # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	# Είσοδος πλήθους των θερμοκρασιών από τον χρήστη
	GetNumberOfYears:	
		la $a0, msg2             # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
		li $v0, 4                # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                  # Εκτέλεση
		
		li $v0,5                 # Κλήση για διάβασμα ακεραίου  
		syscall                  # Εκτέλεση	
		
		blez $v0, WrongMessage   # if $v0 <= 0 goto WrongMessage
		bgt $v0, 9, WrongMessage # if $v0 > 9 goto WrongMessage
		
		sw $v0, k                # k = $v0
			
		jr $ra                   # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	# Σε περίπτωση οπου ο χρήστης δώσει k < 0 ή k > 9 τυπώνεται κατάλληλο μήνυμα στην οθόνη και το πρόγραμμα επιστρέφει στην συνάρτηση GetNumberOfYears
	WrongMessage:
		la $a0, msg3        # Αποθήκευση διεύθυνσης msg3 στον καταχωρητή $a0 
		li $v0, 4           # Κλήση για εκτέλεση εκτύπωσης string	
		syscall             # Εκτέλεση
		
		j GetNumberOfYears  # Άλμα στην συνάρτηση GetNumberOfYears     

	
		

	
