.data
Message: .asciiz "Enter a decimal number: "
Message1: .asciiz "Binary: "
Message2: .asciiz "Hexadecimal: "
binary: .space 9
hex:	.space 9
.text
input:
		li $v0,51		#input from user
		la $a0,Message
		syscall
		beq $a1,0,main		#if input was decimal type, go to main
		beq $a1,-2,exit		#if Cancel was chosen, exit
		j input			#else ask user to input again
main:
		la $s1,0($a0)		#save input value to $s1
		add $s2,$s1,$0		#save input value to $s2
		la $a1,binary		#load address of binary result
		la $a2,hex		#load address of hexadecimal result
		li $s0,8		#init i = 8
binaryLoop:
		subi $s0,$s0,1		#i = i - 1
		bltz $s0,reinit		#if i < 0, jump
		add $t8,$s0,$a1		#$t8 = binary[i]
		div $s2,$s2,2		#divide input value by 2 then update result to $s2
		mfhi $t1		#save remainder to $t1
		addi $t1,$t1,48		#save ascii code of reamainder number to $t1
		sb $t1,0($t8)		#store that character to result's string
		j binaryLoop
reinit:
		li $s0,8
		add $s2,$s1,$0
		j hexLoop
hexLoop:
		subi $s0,$s0,1
		bltz $s0,output
		add $t9,$s0,$a2		#$t9 = hex[i]
		div $s2,$s2,16
		mfhi $t1
		ble $t1, 9, Sum 	# if less than or equal to nine, branch to sum 
		addi $t1, $t1, 55 	# if greater than nine, add 55
		sb $t1,0($t9)
		j hexLoop
Sum:		
		addi $t1,$t1,48
		sb $t1,0($t9)
		j hexLoop
output:
		li $v0, 59		#show binary result
		la $a0, Message1
		la $a1, binary   
		syscall  
		li $v0, 59		#show hexadecimal result
		la $a0, Message2
		la $a1, hex
		syscall
exit:	
		la $v0, 10 
		syscall
