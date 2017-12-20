sw $t0, var # var = $t0
lw $t0, var # $t0 = var

# $t0 : array possition
# $t1 : array[i]
  $t2 : sum
# $t3 : k
# $t4 : just a temp
# $t5 : another temp
# $t9 : var for filling array

a. dn dinoume times me orismata $a0
c. 
d. tiposi me kena oxi me enter
e. dn tiponi ipodiastoli

1
2
3

1
2.
3
4.
5
6.

# Γέροντας Αλέξανδρος 321/2015029
# Τσίπος Ιωάννης      321/2015207
# Ζιώζας Γεώργιος     321/2015058

.data	
	array: .word 0:10 # Δεσμεύει έναν πίνακα 10 ακεραίων, όπου όλοι είναι αρχικοποιημένοι στο 0
	
	space: .asciiz " " 
	enter: .asciiz "\n" ######################3
	
	msg0: .asciiz "Dose to k: "
	msg1: .asciiz "Average temperatures per "
	msg2: .asciiz " years : "
	msg3: .asciiz "K has to be between 0 and 10 \n"
	
	k: .word 0	
	ArrayPos: .word 0
.text

	Main:		
		li $t9, 93
		jal fill
	
		li $s1, 0      # τυπωση δεν χρειαζεται
		jal Print      # Τύπωση μη ταξινομημένου πίνακα
	
		jal GetNumber
		
		li $t0, 0
		li $t2, 0
		
		lw $t3, k		
		
		la $a0, msg1          
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		move $a0, $t3
		li $v0, 1          # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall            # Εκτέλεση
	
		la $a0, msg2
		li $v0, 4 # Κλήση για εκτέλεση εκτύπωσης string	
		syscall # Εκτέλεση
										
		jal CalcAver 
	
		li $v0, 10   # Κλήση για έξοδο
		syscall      # Εκτέλεση
		
	CalcAver:
		lw $t1, array($t0) 
		
		add $t2, $t2, $t1
		add $t0, $t0, 4
						
		mul $t4, $t3, 4		
		lw $t5, ArrayPos		
		add $t4, $t4, $t5	
			
		blt $t0, $t4, CalcAver # if t0 == 4*k break
				
		mtc1 $t2, $f0
		cvt.s.w $f0, $f0
		
		mtc1 $t3, $f1
		cvt.s.w $f1, $f1
		
		div.s $f0, $f0, $f1				
		
		mov.s $f12, $f0	
		li $v0, 2 # Κλήση για εκτέλεση εκτύπωσης float           
		syscall # Εκτέλεση
		
		la $a0, space
		li $v0, 4 # Κλήση για εκτέλεση εκτύπωσης string	
		syscall # Εκτέλεση
		
		li $t2, 0				
		lw $t0, ArrayPos		
		add $t0, $t0, 4
		sw $t0, ArrayPos
		
		mul $t5, $t3, 4
		add $t4, $t0, $t5		
					
		blt $t4, 44, CalcAver # gt 40
		
		jr $ra
		
		
	# Είσοδος αριθμών από τον χρήστη
	GetNumber:	
		la $a0, msg0            # Αποθήκευση διεύθυνσης msg0 στον καταχωρητή $a0 
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		li $v0,5                # Κλήση για διάβασμα ακεραίου  
		syscall                 # Εκτέλεση	
		
		blez $v0,WrongMessage
		bgt $v0, 10, WrongMessage
		
		sw $v0, k
			
		jr $ra                  # Έξοδος από την συνάρτηση και επιστροφή στον καταχωρητή $ra
		
	WrongMessage:
		la $a0, msg3
		li $v0, 4               # Κλήση για εκτέλεση εκτύπωσης string	
		syscall                 # Εκτέλεση
		
		j GetNumber
		
		
	
	# Εκτυπώνει τους όρους του πίνακα στη σειρά 		
	Print:	
		lw $s3, array($s1) # Αποθήκευση της τιμής του πίνακα στη θέση $s1 στον καταχωρητή $s3
	
		move $a0, $s3      # Αποθήκευση της τιμής του καταχωρητή $s3 στον καταχωρητή $a0 
		li $v0, 1          # Κλήση για εκτέλεση εκτύπωσης ακεραίου
		syscall            # Εκτέλεση

		la $a0, space      # Αποθήκευση διεύθυνσης space στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string
		syscall            # Εκτέλεση
	
		add $s1, $s1, 4	   # $s1 = s1 + 4
		blt $s1, 40, Print # if $s1 < 40 goto Print
		
		la $a0, enter      # Αποθήκευση διεύθυνσης enter στον καταχωρητή $a0
		li $v0, 4          # Κλήση για εκτέλεση εκτύπωσης string	
		syscall            # Εκτέλεση
	
		jr $ra             # Έξοδος από την συνάρτηση και άλμα στον καταχωρητή $ra
	
	


# γεμισμα του πινακα με δικες μου τιμες						
fill:

		la $s3, array($s1)
	
		sw $t9, ($s3)
		
		add $t9,$t9,-10		
		
		add $s1, $s1, 4
	
		blt $s1, 40, fill 
				
		jr $ra
