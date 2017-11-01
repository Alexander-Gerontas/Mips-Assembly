#Γέροντας Αλέξανδρος 321/2015029

.data	#Kαταχώρηση των string παρακάτω.
str: .asciiz "Calculation of the Greatest Common Divisor of two integers using Euclid's algorithm."
str1: .asciiz "\n\n Dwse ton prwto akeraio: "
str2: .asciiz "\n Dwse ton deutero akeraio: "
str3 : .asciiz "\n The Greatest Common Divisor is: "
str4 : .asciiz "\n Both numbers are 0s!!"
str5:.asciiz "\n Den orizetai diairesi me to 0"


.text
main:
la $a0, str 				 		# Καταχώρηση στον καταχωρητή $a0.
li $v0, 4							# Εμφάνιση του string στην κονσόλα του QtSpim.
syscall

li $s2,2							#Εκκίνηση μετρητή επαναλήψεων.

eukl_loop:
la $a0, str1 						#Καταχώρηση στον καταχωρητή $a0.
li $v0, 4							#Εμφάνιση του string στην κονσόλα του QtSpim.
syscall 



li $v0, 5							#Aνάγνωση integer από τοn χρήστη.
syscall

move $t0, $v0						#Kαταχώρηση του ακεραίου στoν καταχωρητή $t0.

la $a0, str2 						#Kαταχώρηση στον καταχωρητή $a0.
li $v0, 4							#Εμφάνιση string στην κονσόλα του QtSpim.
syscall 

li $v0, 5							#Ανάγνωση integer από τον χρήστη.
syscall
move $t1, $v0						#Καταχώρηση του ακεραίου στoν καταχωρητή $t1.


add $t2,$t0,$t1 					#Πρόσθεση $t0 και $t1 και καταχώρηση αποτελέσματος στον $t2.
beq $t2,$zero,check_if_zero			#Έλεγχος περίπτωσης μηδενικού αθροίσματος.
return1:						


beq $t1,$zero,show_error			#Εμφάνιση μηνύματος μηδενικής εισόδου.

MKD:
blt $t0,$zero,convert0				#Σε περίπτωση εισόδου αρνητικού αριθμού, γίνεται μετατροπή στον ίσο κατά απόλυτη τιμή αριθμό.
blt $t1,$zero,convert1



div  $t0,$t1                        #Ακέραια διαίρεση $t0 προς $t1.
mflo $s0							#Αποθήκευση αποτελεσμάτων της διαίρεσης και μεταφορά του πηλίκου στον $s0.
mfhi $s1							#Υπόλοιπο στον $t1.

j kataxoriseis						#goto kataxoriseis.
return:					
beq $s1,$zero,end_of_programm    	#Έλεγχος, σε περίπτωση που το $s1 (υπόλοιπο) είναι μηδέν να γίνεται τερματισμός των πράξεων.
j MKD								#goto MKD.

end_of_programm:
la $a0, str3						#Καταχώρηση στον καταχωρητή $a0.
li $v0, 4							#Εμφάνιση string στην κονσόλα του QtSpim.
syscall
li $v0, 1
move $a0, $t0						#Εμφάνιση της τιμής που περιέχει ο $t1.
syscall
j counter							#goto counter.

convert0:
sub $t0,$zero,$t0					#Μετατροπή από αρνητικό σε θετικό αριθμό.
j MKD   							#goto MKD.

convert1:							#Όμοιο με convert0.
sub $t1,$zero,$t1
j MKD

kataxoriseis:						#Πράξεις για την ευκλέιδια διαίρεση.
move $t0,$t1								
move $t1,$s1
j return							#goto return.

show_zero:
la $a0, str4 						#Καταχώρηση στον καταχωρητή $a0.
li $v0, 4							#Εμφάνιση string στην κονσόλα του QtSpim. 
syscall
j counter							#goto counter.

show_error:
la $a0, str5 						#Καταχώρηση στον καταχωρητή $a0.
li $v0, 4							#Εμφάνιση string στην κονσόλα του QtSpim.
syscall
j counter							#goto counter.

counter:
addi $s2,$s2,-1						#Μεταβολή του μετρητή προγράμματος.
bgt $s2, $zero, eukl_loop 			#Συνθήκη τερματισμού επανάληψης.
li $v0, 10 							#Έξοδος.
syscall						

check_if_zero:
beq $t0,$zero,show_zero				#Πραγματοποίηση ελέγχου για μηδενικές εισόδους.
j return1
