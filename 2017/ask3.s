# 321/2015029


.data 	

	loop: .word 0
		
	msg0: .asciiz "Calculation of the Greatest Common Divis or of two integers using Euclid's algorithm\n"

	msg1: .asciiz "Dose ton 1o arithmo: " 
	msg2: .asciiz "Dose ton 2o arithmo: " 
	
	msg3: .asciiz "The Greatest Common Divisor is: "
	
	msg4: .asciiz "Both numbers are 0s!!! \n"

	enter: .asciiz "\n" # ?????? ??? msg1


.text
	main:          
        	la $a0,msg0 
		li $v0,4
		syscall 
	
		la $a0,msg1 
		li $v0,4 
		syscall 
        
	        li $v0,5   
		syscall 
		move $t0,$v0 
	
		la $a0,msg1 
		li $v0,4 
		syscall 
        
        	li $v0,5 
		syscall 
		move $t1,$v0 
               
                jal zero_func
        
        	blt $t0, $zero, negative_func
        	sub $t0, $zero, $t0
        	
        zero_func:
        	bne $t0, $t1, negative_func # cond1: branch if ! (num1  == num2 ) 
        	bne $t0, 0 , negative_func  
        	la $a0,msg4 
		li $v0,4 
		syscall 
		
		jal END
        
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
		add $t0,$t1,0		
		mfhi $t1

		bne $t1,0,euclid_loop
	
		jr $ra 
