# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	#ArraySize: .word 40
	
	space: .asciiz " " 
	enter: .asciiz "\n" 
	
	msg0: .asciiz "Unsorted array: " 
	msg1: .asciiz "Sorted array: " 
	msg3: .asciiz  "Dose ton "
	msg4: .asciiz  "o arithmo: "
	
.text
	
	# Κυρίως πρόγραμμα
	main:	
		li $t9, 100
		li $s0, 1	# $s0 = 1
		li $s1, 0       # $s1 = 0
		
		jal fill2 #  Άλμα στην συνάρτηση fill2
		
		la $a0, msg0  # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0, 4     # Κλήση για εκτέλεση εκτύπωσης string	
		syscall       # Εκτέλεση
		
		li $s1, 0		
		jal print # tiposi ataksinomitou pinaka
					
		#li $s2, ArraySize # $s2 = ArraySize
		li $s2, 40	
		jal sort	
		
		continue:
		
			li $s1, 0   # $s1 = 0
			
			la $a0,msg1 # Αποθήκευση διεύθυνσης msg1 στον καταχωρητή $a0 
			li $v0,4    # Κλήση για εκτέλεση εκτύπωσης string	
			syscall     # Εκτέλεση				
									
			jal print   # Τύπωση ταξινομημένου πίνακα
			
			li $v0, 10  # Κλήση για έξοδο
			syscall     # Εκτέλεση
		
		fill2:
			la $s2, array($s1)
			
			la $a0, msg3  # Αποθήκευση διεύθυνσης msg3 στον καταχωρητή $a0 
			li $v0, 4     # Κλήση για εκτέλεση εκτύπωσης string	
			syscall       # Εκτέλεση
			
			move $a0, $s0 # Αποθήκευση της τιμής του καταχωρητή $s0 στον καταχωρητή $a0 
			li $v0, 1     # Κλήση για εκτέλεση εκτύπωσης ακεραίου
			syscall       # Εκτέλεση
			
			la $a0, msg4 # Αποθήκευση διεύθυνσης msg4 στον καταχωρητή $a0 
			li $v0, 4    # Κλήση για εκτέλεση εκτύπωσης string	
			syscall      # Εκτέλεση
			
			li $v0,5         # Κλήση για διάβασμα ακεραίου  
			syscall          # Εκτέλεση	
			sw $v0, ($s2)
				
			add $s1, $s1, 4 # $s1 = $s1 + 4
			add $s0, $s0, 1 # $s0 = $s0 + 1
		
			blt $s1, 40, fill2 # if $s1 < 40 goto fil2
					
			jr $ra
		
		
	sort:
		beq $s2, 4, continue  # if ($s2 == 4) return;
		
		li $s1, 0 # $s1 = 0
		jal BubbleSortLoop
				
		move $t6, $s1		
		sub $s2, $s2, 4
		
		j sort # bubbleSort(arr, n-4);	
					
		jal continue

	# bubble sort BubbleSortLoop
	BubbleSortLoop:			
		beq $s1,$s2, return # isos na prepei na ginei s2 - 1
	
        	lw $s3, array($s1)      # Αποθήκευση της τιμής του πίνακα στη θέση $s1 στον καταχωρητή $s3   	        	        	  	
        	lw $s4, array + 4($s1)   # Αποθήκευση της τιμής του πίνακα στη θέση $s1 + 4 στον καταχωρητή $s4

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
        	jr $ra # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra	
	
	# Εκτυπώνει τους όρους του πίνακα στη σειρά 		
	print:
	
		lw $s3, array($s1) # Αποθήκευση της τιμής του πίνακα στη θέση $s1 στον καταχωρητή $s3
	
		move $a0,$s3  # Αποθήκευση της τιμής του καταχωρητή $s3 στον καταχωρητή $a0 
		li $v0, 1     # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall       # Εκτέλεση

		la $a0, space # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0
		li $v0, 4     # Κλήση για εκτέλεση εκτύπωσης string
		syscall       # Εκτέλεση
	
		add $s1, $s1, 4	   # $s1 = s1 + 4
		blt $s1, 40, print # if $s1 < 40 goto print
		
		la $a0, enter # Αποθήκευση διεύθυνσης enter στον καταχωρητή $a0
		li $v0, 4     # Κλήση για εκτέλεση εκτύπωσης string	
		syscall       # Εκτέλεση
	
		jr $ra        # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra
	
		
	


# γεμισμα του πινακα με δικες μου τιμες						
fill:

		la $s3, array($s1)
	
		sw $t9, ($s3)
		
		add $t9,$t9,-10		
		
		add $s1,$s1,4
	
		blt $s1, 40, fill 
				
		jr $ra
