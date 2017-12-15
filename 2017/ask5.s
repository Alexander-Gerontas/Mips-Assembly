# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	space: .asciiz " " 
	enter: .asciiz " \n" 
	
	msg0: .asciiz "Unsorted array: " 
	msg1: .asciiz "Sorted array: " 
	msg3: .asciiz  "Dose ton "
	msg4: .asciiz  "o arithmo: "
	
.text
	
	main:	
		la $a0,msg0
		li $v0,4 
		syscall 
		
		li $t9, 100
		li $s1, 0
		
		jal fill #  Άλμα στην συνάρτηση fill
		
		add $s1,$0, 0		
		jal print # tiposi ataksinomitou pinaka
					
		li $s2, 40	# n = 36
		jal sort	
		
		continue:
		
			li $s1, 0		
			
			la $a0,msg1 # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
			li $v0,4    # Κλήση για εκτέλεση εκτύπωσης string	
			syscall     # Εκτέλεση		
			
			jal print # tiposi ataksinomitou pinaka
			
			li $v0, 10  # Κλήση για έξοδο
			syscall     # Εκτέλεση
		
	sort:
		beq $s2,4,return ## if (n == 1) return;
		
		li $s1, 0
		jal BubbleSortLoop
		
		add $t6,$s1, 0
		add $s1,$0, 0
		#jal print
		add $s1,$t6, 0
		
		add $s2, $s2, -4
		jal sort # bubbleSort(arr, n-4);	
					
		jal continue

	BubbleSortLoop:			
		beq $s1,$s2, return # isos na prepei na ginei s2 - 1
	
        	lw $s3, array($s1)
        	        	        	
#        	add $s1, $s1, 4 # s1 = s1 + 4        	
        	lw $s4, array + 4($s1)         	       	
#		add $s1, $s1, -4
        	
        	bgt $s3,$s4, swap #if (arr[i] > arr[i+1])
        	
        	loop_continue:       		        	          	            
			
		   	add $s1, $s1, 4  # s1 = s1 + 4 	
        	
        		j BubbleSortLoop
            
 	# Ανταλλαγή θέσεων μεταξύ στοιχείων του πίνακα	
        swap:                
        	sw $s4, array + 0($s1)
        	sw $s3, array + 4($s1)     
        	 
        	j loop_continue       	        			
        	            	
        return:
        	jr $ra		
		
	print:
	
		lw $s3, array($s1)
	
		move $a0,$s3 
		li $v0,1
		syscall

		la $a0,space
		li $v0,4 
		syscall 
	
		add $s1, $s1, 4
	
		blt $s1, 40, print
		
		la $a0,enter
		li $v0,4 
		syscall 
	
		jr $ra
	
		
	



fill:

		la $s3, array($s1)
	
		sw $t9, ($s3)
		
		add $t9,$t9,-10		
		
		add $s1,$s1,4
	
		blt $s1, 40, fill 
				
		jr $ra
