.data
	msg0: .asciiz "Dose ton proto arithmo: " # Δήλωση του str1
	msg1: .asciiz "Dose ton deutero arithmo: " # Δήλωση του str2
	msg2: .asciiz "Apotelesma: "
	var0: .word 10
	var1: .word 5
.text

main:
	# printf(msgt1)
	la $a0,msg0
	li $v0,4 	
	syscall

	# Eiσαγωγη τιμης απο το πληκτρολογιο (στο v0)
	li $v0,5 
	syscall
	
	# akiro sxolio s2 = v0 , v0 = 0
	move $t0,$v0 
	
	# printf(msg2)
	la $a0,msg1
	li $v0,4 	
	syscall

	# Eiσαγωγη τιμης απο το πληκτρολογιο (στο v0)
	li $v0,5 
	syscall
	
	# akiro sxolio s2 = v0 , v0 = 0
	move $t1,$v0 
	
	# s0 = s0 - s1
	sub $s0, $t0, $t1
	
	# printf(msg2)
	la $a0,msg2
	li $v0,4 	
	syscall
	
	# printf(s0)
	li $v0,1 	
	move $a0,$s0
	syscall
	
	li $v0,10 # exit system call
	syscall # This ends execution
