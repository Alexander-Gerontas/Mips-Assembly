# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	space: .asciiz " "  ######################
	enter: .asciiz "\n" ######################
	
	msg0: .asciiz "Give temperature "
	msg1: .asciiz ": "
	msg2: .asciiz "Dose to k: "
	msg3: .asciiz "K has to be between 0 and 10 \n"
	msg4: .asciiz "Average temperatures per "
	msg5: .asciiz " years: \n"
	
	k: .word 0
	ArrayPos: .word 0 ##############
	endpos: .word 0
	
.text
	Main:			
		li $t0, 0		
		li $t1, 1
		
		#jal GetNumbers
		jal fill
		
		li $t0, 0 ######			
		jal Print ######
		
		jal GetNumber	
		lw $a1, k
						
		la $a0, msg4          
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
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
												
			lw $s4, endpos			
			
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
		
		sw $a0, endpos
		
		lw $t0, ArrayPos		
		add $t0, $t0, 4
		sw $t0, ArrayPos
				
		mtc1 $t2, $f0
		cvt.s.w $f0, $f0
		
		mtc1 $a1, $f1
		cvt.s.w $f1, $f1
		
		div.s $f0, $f0, $f1			
			
		jr $ra
		
	# Είσοδος αριθμών από τον χρήστη
	GetNumbers:
		la $t2, array($t0)
		
		la $a0, msg0
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		move $a0, $t1           
		li $v0, 1               # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall                 # Εκτέλεση
		
		la $a0, msg1
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		li $v0,5                # Κλήση για διάβασμα ακεραίου  
		syscall                 # Εκτέλεση	
		sw $v0, ($t2)          
			
		add $t1, $t1, 1
		add $t0, $t0, 4         
	
		blt $t0, 40, GetNumbers 
				
		jr $ra                  # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra

	GetNumber:	
		la $a0, msg2
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		li $v0,5                # Κλήση για διάβασμα ακεραίου  
		syscall                 # Εκτέλεση	
		
		blez $v0, WrongMessage
		bgt $v0, 9, WrongMessage
		
		sw $v0, k
			
		jr $ra                  # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	WrongMessage:
		la $a0, msg3
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		j GetNumber

	##############
	Print:	
		lw $t2, array($t0) 
	
		move $a0, $t2      
		li $v0, 1          # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall            # Εκτέλεση

		la $a0, space      # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string
		syscall            # Εκτέλεση
	
		add $t0, $t0, 4	   
		blt $t0, 40, Print 
		
		la $a0, enter      # Αποθήκευση διεύθυνσης enter στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string	
		syscall            # Εκτέλεση
	
		jr $ra             # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra
		

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
		
	
