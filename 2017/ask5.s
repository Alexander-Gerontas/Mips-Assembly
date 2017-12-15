# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
		
	space: .asciiz " " 
	enter: .asciiz "\n" 
	
	msg0: .asciiz "Unsorted array: " 
	msg1: .asciiz "Sorted array: " 
	msg2: .asciiz  "Dose ton "
	msg3: .asciiz  "o arithmo: "
	
.text	
	# Κυρίως πρόγραμμα
	Main:	
		li $s0, 1      # $s0 = 1
		li $s1, 0      # $s1 = 0
		
		jal GetNumbers # Μεταφέρουμε την εκτέλεση στη συνάρτηση GetNumbers και αποθηκεύουμε τον μετρητή του προγράμματος
				
		la $a0, msg0   # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0, 4      # Κλήση για εκτέλεση εκτύπωσης string	
		syscall        # Εκτέλεση
		
		li $s1, 0      # $s1 = 0
		jal Print      # Τύπωση μη ταξινομημένου πίνακα
					
		li $s2, 40     # $s2 = 40
		jal BubbleSort # Άλμα στην συνάρτηση BubbleSort
		
		# Επιστροφή στη συνάρτηση μετά την κλήση της BubbleSort
		Main_Continue:
			li $s1, 0    # $s1 = 0		
						
			la $a0, msg1 # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
			li $v0, 4    # Κλήση για εκτέλεση εκτύπωσης string	
			syscall      # Εκτέλεση				
									
			jal Print    # Τύπωση ταξινομημένου πίνακα
			
			li $v0, 10   # Κλήση για έξοδο
			syscall      # Εκτέλεση
		
		# Είσοδος αριθμών από τον χρήστη
		GetNumbers:
			la $s2, array($s1)      # Αποθήκευση της διεύθυνσης του πίνακα στη θέση $s1 στον καταχωρητή $s2
			
			la $a0, msg2            # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
			li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
			syscall                 # Εκτέλεση
			
			move $a0, $s0           # Αποθήκευση της τιμής του καταχωρητή $s0 στον καταχωρητή $a0 
			li $v0, 1               # Κλήση για εκτέλεση εκτύπωσης ακεραίου
			syscall                 # Εκτέλεση
			
			la $a0, msg3            # Αποθήκευση διεύθυνσης msg3 στον καταχωρητή $a0 
			li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
			syscall                 # Εκτέλεση
			
			li $v0,5                # Κλήση για διάβασμα ακεραίου  
			syscall                 # Εκτέλεση	
			sw $v0, ($s2)           # Αποθήκευση της τιμής στην θέση $s1 του πίνακα
				
			add $s1, $s1, 4         # $s1 = $s1 + 4
			add $s0, $s0, 1         # $s0 = $s0 + 1
		
			blt $s1, 40, GetNumbers # if $s1 < 40 goto GetNumbers
					
			jr $ra                  # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	# Ταξινόμηση πίνακα με χρήση BubbleSort
	BubbleSort:
		beq $s2, 4, Main_Continue # if $s2 == 4 goto Main_Continue
		
		li $s1, 0                 # $s1 = 0
		jal BubbleSortLoop        # Άλμα στην συνάρτηση BubbleSortLoop
					
		sub $s2, $s2, 4           # $s2 = $s2 + 4
		
		j BubbleSort              # Μεταφέρουμε την εκτέλεση στη συνάρτηση BubbleSort χωρίς να αποθηκεύσουμε τον μετρητή του προγράμματος					
		jal Main_Continue         # Άλμα στην συνάρτηση Main_Continue

	# Υλοποίηση του βρόνχου "for" της BubbleSort
	BubbleSortLoop:			
		beq $s1,$s2, Return    # if $s1 == $s2 goto Return
	
        	lw $s3, array($s1)     # Αποθήκευση της τιμής του πίνακα στη θέση $s1 στον καταχωρητή $s3   	        	        	  	
        	lw $s4, array + 4($s1) # Αποθήκευση της τιμής του πίνακα στη θέση $s1 + 4 στον καταχωρητή $s4

        	bgt $s3,$s4, Swap      # if array[$s1] > array[$s1+4] goto Swap
        	
        	# Επιστροφή στη συνάρτηση μετά την κλήση της Swap
        	BubbleSortLoop_Continue:       		        	        	          	            			
		   	add $s1, $s1, 4  # $s1 = $s1 + 4 			   	        	
        		j BubbleSortLoop # Άλμα στην συνάρτηση BubbleSortLoop
            
 	# Ανταλλαγή θέσεων μεταξύ στοιχείων του πίνακα	
        Swap:                
     	        sw $s3, array + 4($s1)    # $s3 = array[$s1 + 4]    
        	sw $s4, array + 0($s1)    # $s4 = array[$s1]
        	 
        	j BubbleSortLoop_Continue # Άλμα στην συνάρτηση BubbleSortLoop_Continue  	        			
        	
        # Εκτέλεση της εντολής jr $ra        	
        Return:
        	jr $ra # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra	
	
	# Εκτυπώνει τους όρους του πίνακα στη σειρά 		
	Print:	
		lw $s3, array($s1) # Αποθήκευση της τιμής του πίνακα στη θέση $s1 στον καταχωρητή $s3
	
		move $a0, $s3      # Αποθήκευση της τιμής του καταχωρητή $s3 στον καταχωρητή $a0 
		li $v0, 1          # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall            # Εκτέλεση

		la $a0, space      # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string
		syscall            # Εκτέλεση
	
		add $s1, $s1, 4	   # $s1 = $s1 + 4
		blt $s1, 40, Print # if $s1 < 40 goto Print
		
		la $a0, enter      # Αποθήκευση διεύθυνσης enter στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string	
		syscall            # Εκτέλεση
	
		jr $ra             # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra
	
		
