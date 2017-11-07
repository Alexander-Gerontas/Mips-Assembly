# Γέροντας Αλέξανδρος 321/2015029

# t2 : array[i] 
# t3 : (i) η τρεχων θεση του πινακα
# t4 : το n που περιγραφει ο αλγοριθμος
# t5 : array[i+1]
# t6 : temp
# t9 : metabliti gia na gemiso ton pinaka

# http://www.geeksforgeeks.org/recursive-bubble-sort/


.data	
	array: .word 0:10
	
	space: .asciiz " " 
	enter: .asciiz " \n" # enter
	
	troll: .asciiz "end loop \n" # debugger
	
	msg2: .asciiz "Unsorted array: " 

.text
	
	main:	
		la $a0,msg2 
		li $v0,4 
		syscall 
		
		add $t9, $0, 100
		add $t3, $0, 0
		
		jal fill # gemisma pinaka me dikes mas times
		
		add $t3,$0, 0		
		jal print # tiposi ataksinomitou pinaka
					
		add $t4,$0, 40	# n = 36
		j sort	
		
	sort:
		beq $t4,4,return ## if (n == 1) return;
		
		add $t3,$0, 0
		jal loop
		
		add $t6,$t3, 0
		add $t3,$0, 0
		#jal print
		add $t3,$t6, 0
		
		add $t4, $t4, -4
		jal sort # bubbleSort(arr, n-4);	
					
		jal continue

	loop:	
		move $a0,$t3
		li $v0,1
		#syscall
		
		la $a0,space
		li $v0,4
		#syscall 
		
		move $a0,$t4
		li $v0,1
		#syscall
		
		la $a0,space
		li $v0,4
		#syscall
	
	
		beq $t3,$t4, return # isos na prepei na ginei t4 - 1
	
        	lw $t2, array($t3)
        	        	        	
        	add $t3, $t3, 4 # t3 = t3 + 4        	
        	lw $t5, array($t3)         	       	
		add $t3, $t3, -4
        	
        	bgt $t2,$t5, swap #if (arr[i] > arr[i+1])
        	
        	loop_continue:       	
	        	          	
	        	move $a0,$t3
			li $v0,1
			#syscall
		
			la $a0,space
			li $v0,4
			#syscall    
			
		   	add $t3, $t3, 4   	
        	     	        	        	
	        	
        	
        		la $a0,troll
			li $v0,4
			#syscall
        	       	
        		#jr $ra
        		j loop
            	
        swap:                
        	move $t6, $t2
        	sw $t5, array + 0($t3)
        	sw $t6, array + 4($t3)     
        	 
        	j loop_continue       	        			
        	            	
        return:
        	jr $ra		
			
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
		
		la $a0,enter
		li $v0,4 
		syscall 
	
		jr $ra
	
	end:
		li $v0,10 
		syscall 
		
	continue:
		
		add $t3,$0, 0		
		jal print # tiposi ataksinomitou pinaka
		
		jal end
