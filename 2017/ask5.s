# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	# Δήλωση μηνυμάτων που θα τυπωθούν στην κονσόλα	
	
	space: .asciiz " " 
	enter: .asciiz "\n" 

	msg1: .asciiz "Sorted array: " 
	msg2: .asciiz "Unsorted array: " 
	
	# lathos minima
	msg3: .asciiz  "Dose ton 1o oro tis arithmitikis proodou: "

.text
	# Κυρίως πρόγραμμα 
	main:	
		la $a0, msg2 # Αποθήκευση διεύθυνσης msg2 στον καταχωρητή $a0 
		li $v0,4     # Κλήση για εκτέλεση εκτύπωσης string	
		syscall      # Εκτέλεση
		
		add $t9, $0, 100 # temporary
		li $t3, 0       # $t3 = 0
		
		jal fill # temporary
		
		add $t3,$0, 0		
		jal print # tiposi ataksinomitou pinaka
					
		add $t4, $0, 40	# n = 40
		
		jal sort	
		
		continue:
		
			add $t3,$0, 0
			
			la $a0,msg1
			li $v0,4 
			syscall 				
									
			jal print # tiposi ataksinomitou pinaka
			
			jal end
			
	fill2:

		la $t2, array($t3)
		
		la $a0, msg3 # Αποθήκευση διεύθυνσης msg3 στον καταχωρητή $a0 
		li $v0, 4    # Κλήση για εκτέλεση εκτύπωσης string	
		syscall      # Εκτέλεση
		
		move $a0,$t3            # Αποθήκευση της τιμής του καταχωρητή $t3 στον καταχωρητή $a0 
		li $v0,1                # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall             	# Εκτέλεση
	
		sw $t9, ($t2)
		
		add $t9,$t9,-10		
		
		add $t3,$t3,4
	
		blt $t3, 40, fill2
				
		jr $ra
							
	sort:	
	
		beq $t4, 4, continue # if ( t4 == 4 ) continue;
		
		add $t3,$0, 0
		jal loop
		
		add $t6,$t3, 0
		add $t3,$0, 0

		add $t3,$t6, 0
		
		add $t4, $t4, -4
		j sort # bubbleSort(arr, n-4);	
		
		jr $ra # i mporei na mpei return

	# buuble sort loop
	loop:			
		beq $t3,$t4, return # isos na prepei na ginei t4 - 1
	
        	lw $t2, array($t3)
        	        	        	
        	add $t3, $t3, 4 # t3 = t3 + 4        	
        	lw $t5, array($t3)         	       	
		add $t3, $t3, -4
        	
        	bgt $t2,$t5, swap #if (arr[i] > arr[i+1])
        	
        	loop_continue:      	       	          	
	        	
		   	add $t3, $t3, 4
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
	
		move $a0,$t2 # τυπωση στοιχειου στη θεση $t3
		li $v0,1
		syscall

		la $a0,space # afinoume keno
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
		
	
