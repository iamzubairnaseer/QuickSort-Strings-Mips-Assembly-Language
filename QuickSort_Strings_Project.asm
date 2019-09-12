#COD QuickSort(STRINGS) Project
#Given By Miss Anita
#Program will take 5 inputs from user as a string and sort them using QuickSort Alogrithm
#Developed By :Zubair Naseer(CS-114) and Muhammad Faizan Khurshid(CS-126)

.data
	# data section includes strings to be output to the console
	
	msg:
		.asciiz "COD QuickSort(STRINGS) Project
Given By Miss Anita
Program will take 5 inputs from user as a string and sort them using QuickSort Alogrithm
Developed By :Zubair Naseer(CS-114) and Muhammad Faizan Khurshid(CS-126)

"
	input1:
		.asciiz "Enter first string followed by enter: "
	input2:
		.asciiz "Enter second string followed by enter: "
	input3:
		.asciiz "Enter third string followed by enter: "
	input4:
		.asciiz "Enter fourth sring followed by enter: "
	input5:
		.asciiz "Enter fifth string followed by enter: "
	ask:
		.asciiz "\nDo you want to continue (Yes/No)?\n\nEnter '0' for 'No' and '1' for 'Yes': "
	invalid:
		.asciiz "\nInvlid Input! Try Again...\n"
	end:
		.asciiz "\nThankyou For Using!!! See You Again!!!"

	String_Array:
		  .word 0,0,0,0,0
	
	string1:
		.asciiz ""
	string2:
		.asciiz ""
	string3:	
		.asciiz ""
	string4:	
		.asciiz ""
	string5:	
		.asciiz ""

.text		# text section
.globl main	# call main by SPIM
.ent main	# entering into main
main:

Continue:

	li $v0,4
	la $a0,msg
	syscall

	la $s7,String_Array	# load address 'String_Array' into $s7

	li $v0,4		# preparing for string display
	la $a0,input1		# Adress of String to be printed 
	syscall			# string will be displayed on console

	li $v0,8		# preparing for string input
	la $a0,string1		# address of empty string where new will be stored
	li $a1,32		# length of input string
	syscall			
	
	sw $a0,0($s7)		#Storing string1 at 0th index of 'String_Array'

	li $v0,4
	la $a0,input2
	syscall

	la $a0,string2
	addi $a0,$a0,8
	
	li $v0,8
	li $a1,32
	syscall	

	sw $a0,4($s7)		#Storing string2 at 4th index of 'String_Array'
	
	li $v0,4
	la $a0,input3
	syscall

	la $a0,string3
	addi $a0,$a0,16

	li $v0,8
	li $a1,32
	syscall	

	sw $a0,8($s7)		#Storing string3 at 8th index of 'String_Array'

	li $v0,4
	la $a0,input4
	syscall

	la $a0,string4
	addi $a0,$a0,24

	li $v0,8
	li $a1,32
	syscall	

	sw $a0,12($s7)		#Storing string4 at 12th index of 'String_Array'
	
	li $v0,4
	la $a0,input5
	syscall

	la $a0,string5
	addi $a0,$a0,32

	li $v0,8
	li $a1,32
	syscall	

	sw $a0,16($s7)		#Storing string5 at 16th index of 'String_Array'



	la $a0, String_Array	# passing argument to function(load address 'Byte_Array' into $a0)                     
	li $a1, 0		# passing argument to function(i=0) 

	li $t0,20		
	addi $t0, $t0, -4
	move $a2, $t0		# passing argument to function(j=5-1=4)		

	jal QuickSort		#Calling Function
	

####################################### PRINTING SORTED STRING ##################################################

	move $s7,$v0 #sorted array

checkByte:

	li $t6,0 #i=0
	li $t9,5

iee:
	beq $t6,$t9,goforprint
	addi $t7,$t6,1 #j=i+1
	addi $s6,$s7,4
jay:
		beq $t7,$t9,incI
			lw $t1,0($s7)
			lw $t2,0($s6)
			addi $s1,$t1,0
			addi $s2,$t2,0
			li $t8,0 #k=0
			
Kay:
				beq $t8,$t9,incJ
				lb $t3,0($s1)
				lb $t4,0($s2)
				beq $t3,$t4,incK
				slt $t5,$t3,$t4
				bne $t5,$0,incJ
				sw $t1,0($s6)
				sw $t2,0($s7)
incJ:
	addi $t7,$t7,1
	addi $s6,$s6,4
				j jay
incK:
	addi $s1,$s1,1
	addi $s2,$s2,1
	addi $t8,$t8,1
	j Kay
incI:
	addi $t6,$t6,1
	addi $s7,$s7,4
	j iee



goforprint:
	la $s7,String_Array
	addi $t7,$s7,17
print:
	lw $a0,0($s7)	
	li $v0,4
	syscall

	addi $s7,$s7,4
	slt $t5,$s7,$t7
	bne $t5,$0,print



Ask:
	li $v0,4
	la $a0,ask
	syscall

	li $v0,5
	syscall
	
	beq $0,$v0,exitMain
	addi $a0,$0,1
	beq $a0,$v0,Continue

	li $v0,4
	la $a0,invalid
	syscall
	j Ask	

exitMain:

	li $v0,4
	la $a0,end
	syscall

	li $v0,10
	syscall

############################################QuickSort_function############################################

.globl QuickSort
.ent QuickSort
QuickSort:
## quick sort

# store $s and $ra

	addi $sp,$sp,-36	# Adjest sp
	sw $s0,0($sp)		# store s0
	sw $s1,4($sp)		# store s1
	sw $s2,8($sp)		# store s2
	sw $a1,12($sp)	# store a1
	sw $a2,16($sp)	# store a2
	sw $ra,20($sp)	# store ra
	sw $s7,24($sp)
	sw $s3,28($sp)
	sw $s4,32($sp)

# set $s

	move $s0,$a1		# l = left
	move $s1,$a2		# r = right
	move $s2,$a1		# pivot = left
	move $s3,$a0

# while (l < r)

While:
	bge $s0,$s1,Exit_Function


	
# while (arr[l] <= arr[p] && l < right)
Left:
	# t0 = &arr[l]
	move $s4,$s0				# t0 =  l * 4bit
	add $s4,$s4,$s3	# t0 = &arr[l]
	lw $t9,0($s4)
	lb $s4,0($t9)
	# t1 = &arr[p]
	move $t1,$s2				# t1 =  p * 4bit
	add $t1,$t1,$s3	# t1 = &arr[p]
	lw $t8,0($t1)
	lb $t1,0($t8)
	# check arr[l] <= arr[p]
	bgt $s4, $t1, Right_Condition
	# check l < right
	bge $s0, $a2, Right_Condition
	# l++
	addi $s0,$s0,4
	j Left
	
Right_Condition:

# while (arr[r] >= arr[p] && r > left)
Right:
	# t0 = &arr[r]
	move $s4,$s1				# t0 =  r * 4bit
	add $s4,$s4,$s3	# t0 = &arr[r]
	lw $t9,0($s4)
	lb $s4, 0($t9)
	# t1 = &arr[p]
	move $t1,$s2				# t1 =  p * 4bit
	add $t1,$t1,$s3	# t1 = &arr[p]
	lw $t8,0($t1)
	lb $t1,0($t8)
	# check arr[r] >= arr[p]
	blt $s4,$t1,Swap_Condition
	# check r > left
	ble $s1,$a1,Swap_Condition
	# r--
	addi $s1,$s1,-4
	j Right
	
Swap_Condition:

# if (l >= r)
	blt $s0,$s1,Swap
# SWAP (arr[p], arr[r])
	# t0 = &arr[p]
	move $t6,$s2				# t6 =  p * 4bit
	add $s4,$t6,$s3	# t0 = &arr[p]
	# t1 = &arr[r]
	move $t6,$s1
	add $t1,$t6,$s3	# t1 = &arr[r]
	# Swap
	lw $t2,0($s4)
	lw $t3,0($t1)
	sw $t3,0($s4)
	sw $t2,0($t1)
	
# quick(arr, left, r - 1)
	# set arguments
	move $a2,$s1
	addi $a2,$a2,-4	# a2 = r - 1
	jal QuickSort
	# pop stack
	lw $a1,12($sp)	# load a1
	lw $a2,16($sp)	# load a2
	lw $ra,20($sp)	# load ra
	
# quick(arr, r + 1, right)
	# set arguments
	move $a1,$s1
	addi $a1,$a1,4		# a1 = r + 1
	jal QuickSort
	# pop stack
	lw $a1,12($sp)	# load a1
	lw $a2,16($sp)	# load a2
	lw $ra,20($sp)	# load ra
	
# return
	lw $s0, 0($sp)		# load s0
	lw $s1, 4($sp)		# load s1
	lw $s2, 8($sp)		# load s2
	lw $s7,24($sp)
	addi $sp,$sp,36		# Adjest sp
	jr $ra

Swap:

# SWAP (arr[l], arr[r])
	# t0 = &arr[l]
	move $t6,$s0				# t6 =  l * 4bit
	add $s4,$t6,$s3	# t0 = &arr[l]
	# t1 = &arr[r]
	move $t6,$s1				# t6 =  r * 4bit
	add $t1, $t6, $s3	# t1 = &arr[r]
	# Swap
	lw $t2, 0($s4)
	lw $t3, 0($t1)
	sw $t3, 0($s4)
	sw $t2, 0($t1)
	
	j While
	
############################################end_of_quickSort_function############################################

Exit_Function:
	
# return
	move $v0,$s3 #Address of Sorted String

	lw $s0,0($sp)		# load s0
	lw $s1,4($sp)		# load s1
	lw $s2,8($sp)		# load s2
	lw $s7,24($sp)
	lw $s3,28($sp)
	lw $s4,32($sp)
	addi $sp,$sp,36	# Adjest sp
	jr $ra

	

.end QuickSort