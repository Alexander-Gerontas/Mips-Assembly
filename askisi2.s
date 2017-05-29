﻿#Γέροντας Αλέξανδρος 321/2015029

.data
str: .asciiz "Dwse enan mi arnitiko arithmo: "	# Καταχώρηση του string.
str1: .asciiz " "								# Καταχώρηση των 2 επόμενων string.
str1: .asciiz " "
var0: .word 0 									# Αρχικοποίηση των var0 και var1.
var1: .word 1 																		
.text

main:
la $a0, str 									# Καταχώρηση στον $a0.
li $v0, 4										# Εμφάνιση string στην κονσόλα.
syscall

li $v0, 5										# Ανάγνωση integer αριθμού από το χρήστη.
syscall

lw $t0, var0 									# Φόρτωση τιμών των μεταβλητών στους καταχωρητές $t0 και $t1. 
lw $t1, var1 			

addi $v0, $v0, -1								# Διόρθωση μετρητή για το πλήθος επαναλήψεων και πέρασμα στον καταχωρητή $s0.
move $s0, $v0 								

li $v0, 1
move $a0, $t0
syscall											# Εμφάνιση της πρώτης τιμής της ακολουθίας fibonacci.

fib_loop: 										# Εκκίνηση επανάληψης.
la $a0, str1 									# Καταχώρηση στον $a0.
li $v0, 4										# Εμφάνιση string στην κονσόλα.
syscall
li $v0, 1
move $a0, $t1									# Εμφάνιση της τιμής που περιέχει ο $t1.
syscall


move $t2, $t1									
add $t1, $t1, $t0 							
move $t0, $t2									# Πράξεις υπολογισμού του επόμενου αριθμού της ακολουθίας.
addi $s0, $s0, -1								# Μετητής πλήθους επαναλήψεων.
bgt $s0, $zero, fib_loop 						# Συνθήκη τερματισμού επανάληψης.


li $v0, 10 										# Έξοδος
syscall											# Χρήση εντολής syscall για τερματισμό του προγράμματος.
