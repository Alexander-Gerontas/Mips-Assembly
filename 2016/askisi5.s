#icsd15029 Γέροντας Αλέξανδρος

.data																# Ακολουθεί δήλωση των string
str: .asciiz " Dose ton oro "
str3: .asciiz ": "
array: .word 0:10													# Δήλωση και αρχικοποίηση πίνακα 10 θέσεων τύπου ακεραίου
str1: .asciiz "\n >> Unsorted array:  "
str2: .asciiz "\n\n >> Sorted array:  "
str4: .asciiz " "

.text

main:

	li $s1, 1														# Αρχικοποίηση μετρητή για την get_values
	li $t2, 0														# Χρήση καταχωρητή για έλεγχο ταξινομημένου ή μη ταξινομημένου πίνακα
	li $t4, 0														# Αρχικοποίηση μετρητή για την bubble_sort
	
	get_values:
		la $a0, str 												# Καταχώρηση string στον $a0
		li $v0, 4													# Εμφάνιση string στην κονσόλα
		syscall
		li $v0, 1													# Eμφάνιση αθροίσματος
		move $a0, $s1												# Εμφάνιση της τιμής που περιέχει ο $s1
		syscall
		la $a0, str3 												# Καταχώρηση string στον $a0
		li $v0, 4													# Εμφάνιση string στην κονσόλα
		syscall
		li $v0, 5													# Ανάγνωση integer από το χρήστη για την πρώτη τιμή της ακολουθίας
		syscall
		move $t1, $v0												# Kαταχώρηση του ακεραίου που αναγνώστηκε στoν καταχωρητή $t1
		sw $t1, array($t0)											# Καταχώρηση της τιμής του $t1 στο πρώτο στοιχείο του πίνακα
		add $t0,$t0, 4												# Αύξηση δείκτη θέσης του πίνακα
		add $s1,$s1,1												# Αύξηση μετρητή επανάληψης
		ble $s1,10,get_values										# Συνθήκη τερματισμού get_values
		
		la $a0, str1												# Καταχώρηση string στον $a0
		li $v0, 4													# Εμφάνιση string στην κονσόλα
		syscall
		
	start_of_show_array:		
		li $s1, 1													# Δημιουργία μετρητή για τη show_array
		li $t3, 0													# Αρχικοποίηση δείκτη θέσης πίνακα
												
		show_array:		
			lw $t0, array+0($t3)									# Φόρτωση στον καταχωρητή $t0 την εκάστοτε τιμή του πίνακα, από τη θέση που δείχνει ο εκάστοτε δείκτης
			li $v0, 1													
			move $a0, $t0											# εμφάνιση τιμής του καταχωρητή $t0						
			syscall			
			la $a0, str4 											# Καταχώρηση string στον $a0
			li $v0, 4												# Εμφάνιση string στην κονσόλα
			syscall
			addi $s1, $s1, 1										# Μείωση μετρητή επανάληψης
			add $t3,$t3, 4											# Μείωση δείκτη θέσης πίνακα
			ble $s1, 10, show_array									# Συνθήκη τερματισμού show_array		
			beq $t2, 0, bubble_sort
			beq $t2, 1, end_of_programm
		
		
		bubble_sort:
			li $t5, 40												# Αρχικοποίηση μετρητών internal_loop
			li $t9, 40
			li $t8, 0												# Ορισμός πίνακα ως ταξινομημένου
			internal_loop:						
					add $t9,$t9,-4									# Μείωση μετρητή για το intenal loop
					lw $t6, array+0($t9)							# Φόρτωση στους καταχωρητές $t6 και $t7 τις εκάστοτε τιμές που δείχνουν οι πίνακες
					lw $t7, array+0($t5)
					bgt	$t6,$t7,swap								# Έλεγχος για αντιμετάθεση
					return:
					add $t5,$t5,-4									# Μείωση μετρητή για το internal_loop
					ble $t5,$t4,break_internal_loop					# Συνθήκες τερματισμού internal loop
					bgt $t5,$t4,internal_loop						
			
		end_of_bubble_sort:
		li $t2, 1
		la $a0, str2 												# Καταχώρηση string στον $a0
		li $v0, 4													# Εμφάνιση string στην κονσόλα
		syscall	
		j start_of_show_array
		
		end_of_programm:
		li $v0, 10 													# Tερματισμός προγράμματος									
		syscall	

swap:
	sw $t6, array+0($t5)											# Αντιμετάθεση στοιχείων			
	sw $t7, array+0($t9)	
	li $t8,1														# Ορισμός πίνακα ως μη ταξινομημένου
j return

break_internal_loop:							
	add $t4,$t4,4													# Αύξηση μετρητή bubble_sort
	beq $t8,$zero,end_of_bubble_sort								# Συνθήκη τερματισμού bubble_sort
j bubble_sort
