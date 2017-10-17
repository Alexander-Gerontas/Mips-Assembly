.data
	msg0: .asciiz "Dose ton proto arithmo: "
	msg1: .asciiz "Dose ton deutero arithmo: "
	msg2: .asciiz "Apotelesma: "
	var0: .word 10
	var1: .word 5
.text

main:
	lw $s0, var0         # Load register $s0 with the value of var0
	lw $s1, var1         # Load register $s1 with the value of var1

	# printf(msgt1)
	la $a0,msg0
	li $v0,4 	
	syscall

	# Eiσαγωγη τιμης απο το πληκτρολογιο (στο v0)
	li $v0,5 
	syscall
	
	# akiro sxolio s2 = v0 , v0 = 0
	move $s0,$v0 
	
	# printf(msg2)
	la $a0,msg1
	li $v0,4 	
	syscall

	# Eiσαγωγη τιμης απο το πληκτρολογιο (στο v0)
	li $v0,5 
	syscall
	
	# akiro sxolio s2 = v0 , v0 = 0
	move $s1,$v0 
	
	# s0 = s0 - s1
	sub $s0, $s0, $s1
	
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
