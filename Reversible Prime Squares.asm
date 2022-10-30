.data
	massage:	.asciiz	"The first 10 reversible prime square numbers are :\n"
	newLine:	.asciiz	"\n"
.text
	main:
		li	$t1, 1	#count
		li	$t2, 1	#num
		
		for1:
			bgt	$t1, 10, Exit
			move	$a0, $t2
			
			jal primeNum
			
			move	$t3, $v1
			
			beqz	$v1, go_to_for1
			
			mul	$t0, $t2, $t2		#$t0, sqr
			
			move	$a0, $t0
			
			# reversing the square of a prime
			jal	reverseNum
			
			move	$t6, $v1		#$t6 = reverse
			move	$a0, $v1		#$a0 = reverse
			move	$a1, $t0		#$a1 = square
			
			# Checking palindrme
			
			jal	checkPal
			
			beqz	$v1, go_to_for1
			
			move	$a0, $t6
			
			jal	CheckSquare
			
			beqz	$v1, go_to_for1
			
			move	$a0, $t6
			
			jal	findSqrt
			
			move	$a0, $v1
			
			jal	primeNum
			
			beqz	$v1, go_to_for1
			
			li	$v0, 1
			move	$a0, $t0
			syscall
			
			li	$v0, 4
			la	$a0, newLine
			syscall
			
			addi	$t1, $t1, 1
			addi	$t2, $t2, 1
			
			j	for1
			
	li	$v0, 10
	syscall

Exit:
	li	$v0, 10
	syscall

primeNum:
	li	$t4, 0		# $t4, count2
	li	$t5, 1		# $t5, i 
	
	for2:
		bgt	$t5, $a0, if1
		div	$a0, $t5
		mfhi	$t6		# $t6, remainder
		
		bnez	$t6, go_to_for2
	
		if1:
			bne	$t4, 2, num_is_prime
			b	num_is_not_prime
	
		addi	$t4, $t4, 1
		addi	$t5, $t5, 1	
	
		j for2
	
	jr	$ra
	
go_to_for1:
	addi	$t2, $t2, 1
	j	for1

go_to_for2:
	addi	$t5, $t5, 1
	j	for2	
			
num_is_prime:
	li	$v1, 1
	
	jr	$ra
	
num_is_not_prime:
	li	$v1, 0
	
	jr	$ra
	
reverseNum:
	li	$t4, 0		#t4 = reverse = 0
	li	$s0, 10
	while:
		beqz	$a0, return_rev
		
		mul	$t4, $t4, 10
		div	$a0, $s0
		mfhi	$t5
		
		add	$t4, $t4, $t5
		
		div	$a0, $a0, 10		#num /= 10
		
		j	while
		
	jr	$ra

return_rev:
	move	$v1, $t4
	
	jr	$ra

checkPal:
	bne	$a0, $a1, returnOne
	b	returnZero
	
returnZero:
	li	$v1, 0
	
	jr	$ra

returnOne:
	li	$v1, 1
	
	jr	$ra
	
CheckSquare:
	li	$t4, 2
	
	for3:
		bgt	$t4, $a0, returnValue
		
		div	$a0, $t4
		mfhi	$t5
		
		bne	$t5, $t4, go_to_for3
		
		beqz	$t5, return_one
		b	return_zero
		
		j	for3
	jr	$ra
	
go_to_for3:
	addi	$t4, $t4, 1
	
	j	for3
	
return_one:
	li	$t9, 1
	jr	$ra
	
return_zero:
	li	$t9, 0
	jr	$ra
	
returnValue:
	move	$v1, $t9
	
	jr	$ra
	
findSqrt:
	li	$t4, 2	# i = $t4
	
	for4:
		bgt	$t4, $a0, return_i
		div	$a0, $t4
		mfhi	$t5
		
		bne	$t5, $t4, go_to_for4
		b	assignment
		
		addi 	$t4, $t4, 1
		j	for4
		
	jr	$ra
		
go_to_for4:
	addi 	$t4, $t4, 1
	
	j	for4
	
return_i:
	move	$v1, $t8
	
	jr	$ra

assignment:
	move	$t8, $t4
	
	jr	$ra