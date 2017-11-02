# 321/2015029


.data 	

	loop: .word 0
		
	msg0: .asciiz "Calculation of the Greatest Common Divis or of two integers using Euclid's algorithm\n"

	msg1: .asciiz "Dose ton 1o arithmo: " 
	msg2: .asciiz "Dose ton 2o arithmo: " 
	
	msg3: .asciiz "The Greatest Common Divisor is: "
	
	msg4: .asciiz "Both numbers are 0s!!! \n"

	enter: .asciiz "\n" 

.text
	main:          
        	la $a0,msg0  # tiposi arxikou minimatos
		li $v0,4
		syscall 
	
		la $a0,msg1 # ζηταμε απο τον χρηστη 1 αριθμο
		li $v0,4 
		syscall 
        
	        li $v0,5   
		syscall 
		move $t0,$v0 
	
		la $a0,msg2 #ζηταμε απο τον χρηστη τον 2ο αριθμο
		li $v0,4 
		syscall 
        
        	li $v0,5 
		syscall 
		move $t1,$v0 
               
                jal zero_func # ελεγχος αν και οι 2 αριθμοι ειναι 0
        
        	bltz $t0, negative_func
        	sub $t0, $zero, $t0
        	
        zero_func:
        	bne $t0, $t1, return # cond1: branch if ! (num1  == num2 ) 
        	bne $t0, 0 , return
        	la $a0,msg4 
		li $v0,4 
		syscall 
		
		jal END
	
	return : 
		jr $ra # επιστροφη στη Main
        
	negative_func:
		bgt $t1, $zero , ELSE 
		sub $t1, $zero, $t1
                
	ELSE:
		jal euclid_loop
	
		la $a0,msg3 
		li $v0,4 
		syscall 
	
		move $a0,$t0
		li $v0,1
		syscall
	
	END:
		li $v0,10 
		syscall 
	
	euclid_loop:
		
		div $t0, $t1
		add $t0,$t1,0 # patenta
		mfhi $t1

		bne $t1,0,euclid_loop
	
		jr $ra 
