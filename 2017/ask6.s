# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	space: .asciiz " "  ######################
	enter: .asciiz "\n" ######################
	
	msg0: .asciiz "Give temperature "
	msg1: .asciiz ": "
	msg2: .asciiz "Give k: "
	msg3: .asciiz "K has to be between 0 and 10 \n"
	msg4: .asciiz "Average temperatures per "
	msg5: .asciiz " years: \n"
	
	k: .word 0
	ArrayPos: .word 0
	EndPos: .word 0 
	LoopCount: .word 1
	
.text
	Main:			
		li $t0, 0		
				
		jal GetTemperatures # Άλμα στην συνάρτηση GetTemperatures
		#jal fill
		
		li $t0, 0 ######				
		
		jal GetNumber	
		lw $a1, k
						
		la $a0, msg4          
		li $v0, 4  # Κλήση για εκτέλεση εκτύπωσης string	
		syscall # Εκτέλεση
		
		lw $a0, k	
		li $v0, 1          # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall            # Εκτέλεση
	
		la $a0, msg5
		li $v0, 4 # Κλήση για εκτέλεση εκτύπωσης string	
		syscall # Εκτέλεση		
													 
		func:
			li $t2, 0
			lw $a0, ArrayPos
			jal CalcAver 	
						
			mov.s $f12, $f0	
			li $v0, 2 # Κλήση για εκτέλεση εκτύπωσης float           
			syscall # Εκτέλεση
		
			la $a0, space
			li $v0, 4 # Κλήση για εκτέλεση εκτύπωσης string	
			syscall # Εκτέλεση
												
			lw $s4, EndPos			
			
			blt $s4, 40, func			
		
		li $v0, 10   # Κλήση για έξοδο
		syscall      # Εκτέλεση
	
	CalcAver:
		lw $t1, array($a0) 
		
		add $t2, $t2, $t1
		add $a0, $a0, 4
						
		mul $t4, $a1, 4		
		lw $t5, ArrayPos
		add $t4, $t4, $t5
			
		blt $a0, $t4, CalcAver # if t0 == 4*k break
		
		sw $a0, EndPos 
		
		lw $t0, ArrayPos		
		add $t0, $t0, 4
		sw $t0, ArrayPos
				
		mtc1 $t2, $f0    # Μεταφορά του ακέραιου καταχωρητή $t2, στον καταχωρητή κινητής υποδιαστολής $f0
		cvt.s.w $f0, $f0 # Μετατροπή της τιμής του καταχωρητή $f0 από ακέραιο σε κινητής υποδιαστολής
		
		mtc1 $a1, $f1    # Μεταφορά του ακέραιου καταχωρητή $a1, στον καταχωρητή κινητής υποδιαστολής $f1
		cvt.s.w $f1, $f1 # Μετατροπή της τιμής του καταχωρητή $f1 από ακέραιο σε κινητής υποδιαστολής
		
		div.s $f0, $f0, $f1 # $f0 = $f0 / $f1			
			
		jr $ra # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	# Είσοδος αριθμών από τον χρήστη
	GetTemperatures:
		la $t1, array($t0) # Αποθήκευση της διεύθυνσης του πίνακα στη θέση $t0 στον καταχωρητή $t1
		
		la $a0, msg0      # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0, 4         # Κλήση για εκτέλεση εκτύπωσης string	
		syscall           # Εκτέλεση
		
		lw $a0, LoopCount # $a0 = LoopCount         
		li $v0, 1         # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall           # Εκτέλεση
		
		add $a0, $a0, 1   # $a0 = $a0 + 1
		sw $a0, LoopCount # LoopCount = $a0
		
		la $a0, msg1      # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0
		li $v0, 4         # Κλήση για εκτέλεση εκτύπωσης string	
		syscall           # Εκτέλεση
		
		li $v0,5          # Κλήση για διάβασμα ακεραίου  
		syscall           # Εκτέλεση	
		sw $v0, ($t1)          
			
		add $t0, $t0, 4         
	
		blt $t0, 40, GetTemperatures # if $t0 < 40 goto GetTemperatures
				
		jr $ra                  # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra

	GetNumber:	
		la $a0, msg2             # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
		li $v0, 4                # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                  # Εκτέλεση
		
		li $v0,5                 # Κλήση για διάβασμα ακεραίου  
		syscall                  # Εκτέλεση	
		
		blez $v0, WrongMessage   # if $vo <= 0 goto WrongMessage
		bgt $v0, 9, WrongMessage # if $vo > 9 goto WrongMessage
		
		sw $v0, k                # k = $v0
			
		jr $ra                   # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	WrongMessage:
		la $a0, msg3
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		j GetNumber

	
		

	#################					
	fill:

		la $t2, array($t0)
		
		li $t9, 51
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 95
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 88
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 40
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 33
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 45
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 51
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 61
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 51
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		la $t2, array($t0)
		
		li $t9, 51
	
		sw $t9, ($t2)			
		
		add $t0, $t0, 4
		
		jr $ra		
		
	
