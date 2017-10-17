.data
	#str: .asciiz "Hello world! \n"
	line: .asciiz "lol\n"
	var0: .word 10
	var1: .word 5
	temp: .word 50
.text

main:
	lw $s0, var0         # Load register $s0 with the value of var0
	lw $s1, var1         # Load register $s1 with the value of var1
	lw $s2, temp         # Load register $s2 with the value of temp

	# Eiσαγωγη τιμης στο v0
	li $v0,5 
	syscall
	
	#s2 = v0 , v0 = 0
	move $s2,$v0 
	
	# printf(s2) οπου s2 = temp	
	li $v0,1 
	move $a0,$s2
	syscall
	
	# printf(\n)
	la $a0,line
	li $v0,4 	
	syscall
	
	# printf(s0)	
	li $v0,1 	
	move $a0,$s0
	syscall
	
	 # s0 = s0 - s1
	sub $s0, $s0, $s1
	
	# printf(s0)
	li $v0,1 	
	move $a0,$s0
	syscall
	
	li $v0,10 # exit system call
	syscall # This ends execution

#sub $s0, $s0, $s1    # Add the two registers and place the sum in $s0

#sw $s0, sum          # Store the sum in memory (in variable sum)

#la $a0, str          # To print a string, first its address should be stored to register $a0
#li $v0, 4            # System call value for print_string. It should be stored to $v0. Refer to Figure A.9.1 of Assemblers, Linkers and the SPIM Simulator for more details
#syscall              # Use this MIPS command to execute a system call

#move $a0, $s0        # To print an integer, it should be first stored to register $a0
#li $v0, 1            # System call value for print_int
#syscall
