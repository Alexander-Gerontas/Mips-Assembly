# 321/2015029

.data 	
	loop: .word 0 # H μεταβλητή loop είναι ο μετρητής επαναλήψεων του βρόνχου

	space: .asciiz "\n\n" # enter

	msg0: .asciiz "Calculation of the Greatest Common Divis or of two integers using Euclid's algorithm \n"
	msg1: .asciiz "Dose ton 1o arithmo: " 
	msg2: .asciiz "Dose ton 2o arithmo: " 
	msg3: .asciiz "The Greatest Common Divisor is: "
	msg4: .asciiz "Both numbers are 0s!!! \n"

.text
	main:     
		lw $t3, loop
	          
        	la $a0,msg0  # tiposi arxikou minimatos
		li $v0,4
		syscall 
	
	program_loop:
		
		add $t3,$t3,1 # loop += 1
				
		jal give_numbers
				
		jal zero_func_t0
		jal euclid_loop
		jal print_result
		
		
		beq $t3,1,program_loop 

		jal exit
	
	# eleγχει περιπτωσεις οπως αν και οι 2 αριθμοι ειναι 0 η μονο ο ενας
	zero_func_t0:
		bnez $t0, zero_func_t1 # if num1 != 0 
	        beqz $t1, print_both_numbers_0        
	         		
		#jal exit
		
		add $t0,$t1,0 # patenta
		jal print_result
		
		jal exit
		
		jal print_result
	        
        
        	#la $a0,msg4 
		#li $v0,4 
		#syscall 
		
	give_numbers: #xrisimi
		la $a0,msg1  # ζηταμε απο τον χρηστη 1 αριθμο
		li $v0,4
		syscall
		
		li $v0,5   
		syscall 
		move $t0,$v0 
		
		la $a0,msg2  #ζηταμε απο τον χρηστη τον 2ο αριθμο
		li $v0,4
		syscall
		
		li $v0,5  # μεταφορα ακεραιου στον $t1 
		syscall 
		move $t1,$v0 
	
		
	zero_func_t1:
		jr $ra 
	
	print_both_numbers_0:
		la $a0,msg4  # both numbers are 0
		li $v0,4
		syscall
		
		jal program_loop	
				
	euclid_loop:		#xrisimi
		div $t0, $t1
		add $t0,$t1,0 # patenta
		mfhi $t1

		bne $t1,0,euclid_loop
	
		jr $ra 
		
	print_result:
		la $a0,msg3 # τυπωση msg3 
		li $v0,4 
		syscall 		
		
		move $a0,$t0 # τυπωση αποτελεσματος
		li $v0,1
		syscall
		
		la $a0,space
		li $v0,4 
		syscall 
		
		jr $ra 
	
	exit:
		li $v0,10 
		syscall 
