# ???????? ?????????? 321/2015029

# t2 : array[i] 
# t3 : (i) η τρεχων θεση του πινακα
# t4 : το n που περιγραφει ο αλγοριθμος
# t5 : array[i+1]
# t6 : temp
# t9 : metabliti gia na gemiso ton pinaka


.data	
	array: .word 0:10
	
	space: .asciiz " " # enter
	enter: .asciiz " \n" # enter
	
	msg2: .asciiz "Unsorted array: " 

.text
	
	main:	
		la $a0,msg2 
		li $v0,4 
		syscall 
		
		add $t9, $zero, 100
		add $t3, $zero, 0
		
		jal fill # gemisma pinaka me dikes mas times
		
		add $t3,$0, 0		
		jal print # tiposi ataksinomitou pinaka
		
		#la $t2, array($t3)
			
		add $t4,$0, 36	# n = 36
		jal sort
		
	continue:
		
		add $t3,$0, 0		
		jal print # tiposi ataksinomitou pinaka
		
		jal end
	
	sort:
		beq $t4,4,return ## if (n == 1) return;
		
		add $t3,$0, 0
		jal loop
		
		add $t4, $t4, -4
		jal sort # bubbleSort(arr, n-4);
			
		jal continue

	loop:	
        	lw $t2, array($t3)
        	
        	add $t3, $t3, 4 # t3 = t3 + 4        	
        	lw $t5, array($t3)        	
		add $t3, $t3, -4
        	
        	bgt $t2,$t5, swap #if (arr[i] > arr[i+1])
        	        	       	
        	add $t3, $t3, 4       	
        	        	
        	blt $t3,$t4, loop # isos na prepei na ginei t4 - 1
        	
        	jr $ra
            	
        swap:                
        	move $t6, $t2
        	sw $t5, array + 0($t3)
        	sw $t6, array + 4($t3)     
        	
        	 jr $ra 	  	
        	            	
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
