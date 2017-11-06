# Γέροντας Αλέξανδρος 321/2015029

.data	
	array: .word 0:10
	
	space: .asciiz " " # enter
	msg2: .asciiz "Unsorted array: " 

.text
	
	main:	
		la $a0,msg2 
		li $v0,4 
		syscall 
		
		add $t9, $zero, 100
		add $t3, $zero, 0
		
		jal fill
		
		add $t3,$0, 0
		
		jal print
		
		jal end
		
	fill:

		la $t2, array($t3)
	
		sw $t9, ($t2)
		
		add $t9,$t9,-10		
		
		add $t3,$t3,4
	
		blt $t3, 40, fill 
				
		jr $ra
		
	print:
	
		lw $t2, array($t3)
	
		move $a0,$t2 
		li $v0,1
		syscall

		la $a0,space
		li $v0,4 
		syscall 
	
		add $t3, $t3, 4
	
		blt $t3, 40, print
	
		jr $ra
	
	end:
		li $v0,10 
		syscall 
