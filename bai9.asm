.data
	String1:	.asciiz "                                           *************     \n"
	String2:	.asciiz "**************                            *3333333333333*    \n"
	String3:	.asciiz "*222222222222222*                         *33333********     \n"
	String4:	.asciiz "*22222******222222*                       *33333*            \n"
	String5:	.asciiz "*22222*      *22222*                      *33333********     \n"
	String6:	.asciiz "*22222*       *22222*      *************  *3333333333333*    \n"
	String7:	.asciiz "*22222*       *22222*    **11111*****111* *33333********     \n"
	String8:	.asciiz "*22222*       *22222*  **1111**       **  *33333*            \n"
	String9:	.asciiz "*22222*      *222222*  *1111*             *33333********     \n"
	String10:	.asciiz "*22222*******222222*  *11111*             *3333333333333*    \n"
	String11:	.asciiz "*2222222222222222*    *11111*              *************     \n"
	String12:	.asciiz "***************       *11111*                                \n"
	String13:	.asciiz "      ---              *1111**                               \n"
	String14:	.asciiz "    / o o \\             *1111****   *****                    \n"
	String15:	.asciiz "    \\   > /              **111111***111*                     \n"
	String16:	.asciiz "     -----                 ***********    dce.hust.edu.vn    \n"
	Message0:	.asciiz "------------IN CHU-----------\n"
	Phan1:		.asciiz "1. In ra chu\n"
	Phan2:		.asciiz "2. In ra chu rong\n"
	Phan3:		.asciiz "3. Thay doi vi tri\n"
	Phan4:		.asciiz "4. Doi mau cho chu\n"
	Thoat:		.asciiz "5. Thoat\n"
	Nhap:		.asciiz "Nhap gia tri: "
	Invalid:	.asciiz	"So nhap vao khong hop le!!!\n"
	ChuD:		.asciiz "Nhap mau cho chu D(0->9): "
	ChuC:		.asciiz "Nhap mau cho chu C(0->9): "
	ChuE:		.asciiz "Nhap mau cho chu E(0->9): "

.text
	li $t5, 50 					# t5 mau chu hien tai cua chu D
	li $t6, 49 					# t6 mau chu hien tai cua chu C
	li $t7, 51 					# t7 mau chu hien tai cua chu E

main:
	la $a0, Message0				# nhap menu
	li $v0, 4
	syscall
	
	la $a0, Phan1	
	li $v0, 4
	syscall
	la $a0, Phan2	
	li $v0, 4
	syscall
	la $a0, Phan3	
	li $v0, 4
	syscall
	la $a0, Phan4	
	li $v0, 4
	syscall
	la $a0, Thoat	
	li $v0, 4
	syscall
	la $a0, Nhap	
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	Case1menu:
		addi $v1, $0, 1
		bne $v0, $v1, Case2menu
		j Menu1
	Case2menu:
		addi $v1, $0, 2
		bne $v0, $v1, Case3menu
		j Menu2
	Case3menu:
		addi $v1, $0, 3
		bne $v0, $v1, Case4menu
		j Menu3
	Case4menu:
		addi $v1, $0, 4
		bne $v0, $v1, Case5menu
		j Menu4
	Case5menu:
		addi $v1, $0, 5
		bne $v0, $v1, defaultmenu
		j Exit
	defaultmenu:
		la $a0, Invalid	
		li $v0, 4
		syscall
		j main

##### in ra
Menu1:	
	addi $s0, $0, 0					# bien dem = 0
	addi $s1, $0, 16				# tong so string chu la 16
	
	la $a0, String1
Loop:	
	beq $s1, $s0, main
	li $v0, 4
	syscall
	
	addi $a0, $a0, 63				# moi string co 63 ki tu, tang dia chi luu trong $a0 de in ra string tiep theo
	addi $s0, $s0, 1				# tang bien dem
	j Loop

##### bo het so o giua chi giu lai vien
Menu2: 	
	addi $s0, $0, 0					# bien dem tung hang = 0
	addi $s1, $0, 16
	la $s2, String1					# $s2 la dia chi cua string1
		
Lap:	
	beq $s1, $s0, main
	addi $t0, $0, 0					# $t0 la bien dem tung kí tu cua 1 hang = 0
	addi $t1, $0, 63 				# $t1 max 1 hang là 63 ki tu
	
In1hang:
	beq $t1, $t0, End
	lb $t2, 0($s2)					# $t2 luu gia tri cua tung phan tu trong string1
	
	bgt $t2, 47, Tu0den9	 			# neu trong khoang tu 0 den 9 thi nhay den Tu0den9
	j Inkytu
	Tu0den9: 	
		bgt $t2, 57, Inkytu	 		# neu lon hon 9 nua thi van ko doi
		addi $t2, $0, 0x20	 		# thay doi $t2 thanh dau cach
		j Inkytu	
Inkytu: 	
	li $v0, 11 					# in tung ki tu
	addi $a0,$t2,0
	syscall
	
	addi $s2, $s2, 1				# sang chu tiep theo
	addi $t0, $t0, 1				# bien dem chu
	j In1hang
End:	
	addi $s0, $s0, 1 				# tang bien dem hang len 1
	j Lap

##### doi vi tri chu
Menu3:
	addi $s0, $0, 0					# bien dem tung hang = 0
	addi $s1, $0, 16
	la $s2, String1 				# $s2 luu dia chi cua string1
Lap2:	
	beq $s1, $s0, main
							# tao thanh 3 string nho
	sb $0, 21($s2)
	sb $0, 41($s2)
	sb $0, 57($s2)
	#doi vi tri
	li $v0, 4 
	la $a0, 42($s2) 				#in chu E
	syscall
	
	li $v0, 4 
	la $a0, 22($s2) 				# in chu C
	syscall
	
	li $v0, 4 
	la $a0, 0($s2) 					# in chu D
	syscall
	
	li $v0, 4 
	la $a0, 58($s2)
	syscall
	
	# ghep lai thanh string ban dau
	addi $t1, $0, 0x20
	sb $t1, 21($s2)
	sb $t1, 41($s2)
	sb $t1, 57($s2)
	
	addi $s0, $s0, 1				# tang bien dem
	addi $s2, $s2, 63				
	j Lap2

##### doi mau cho chu
Menu4: 
NhapmauD:	
	li $v0, 4		
	la $a0, ChuD
	syscall
	
	li $v0, 5					# lay mau cua ki tu D
	syscall

	blt $v0,0, NhapmauD
	bgt $v0,9, NhapmauD
		
	addi $s3, $v0, 48				# $s3 luu mau cua chu D
NhapmauC:	
	li $v0, 4		
	la $a0, ChuC
	syscall
	
	li $v0, 5					# lay mau cua ki tu C
	syscall

	blt $v0, 0, NhapmauC
	bgt $v0, 9, NhapmauC
				
	addi $s4,  $v0, 48				# $s4 luu mau cua chu C
NhapmauE:	
	li $v0, 4		
	la $a0, ChuE
	syscall
	
	li $v0, 5					# lay mau cua ki tu E
	syscall

	blt $v0, 0, NhapmauE
	bgt $v0, 9, NhapmauE
			
	addi $s5, $v0, 48				# $s5 luu mau cua chu E
	
	addi $s0, $0, 0					# bien dem tung hang = 0
	addi $s1, $0, 16
	la $s2,String1					# $s2 la dia chi cua string1
	li $a1, 48 					# gia tri cua so 0
	li $a2, 57 					# gia tri cua so 9

Lapdoimau:	
	beq $s1, $s0, Updatemau
	addi $t0, $0, 0					# $t0 la bien dem tung kí tu cua 1 hang = 0
	addi $t1, $0, 63 				# $t1 max 1 hang la 63 ki tu
	
In1hangdoimau:
	beq $t1, $t0, Enddoimau
	lb $t2, 0($s2)					# $t2 luu gia tri cua tung phan tu trong string1
	CheckD: bgt $t0, 21, CheckC 			# kiem tra het chu D chua
		beq $t2, $t5, fixD
		j Checknext
	CheckC: bgt $t0, 41, CheckE	 		# kiem tra het chu C chua
		beq $t2, $t6, fixC
		j Checknext
	CheckE: beq $t2, $t7, fixE
		j Checknext
		
fixD: 	
	sb $s3, 0($s2)					# thay doi mau chu D
	j Checknext
fixC: 	
	sb $s4, 0($s2)					# thay doi mau chu C
	j Checknext
fixE: 	
	sb $s5, 0($s2)					# thay doi mau chu E
	j Checknext
Checknext: 	
	addi $s2, $s2, 1				# sang chu tiep theo
	addi $t0, $t0, 1				# tang bien dem ky tu
	j In1hangdoimau
Enddoimau:
	li $v0, 4  
	addi $a0, $s2, -63
	syscall
	addi $s0, $s0, 1 				# tang bien dem hang
	j Lapdoimau
Updatemau: 
	move $t5, $s3					# thay doi mau chu hien tai cua chu D
	move $t6, $s4					# thay doi mau chu hien tai cua chu C
	move $t7, $s5					# thay doi mau chu hien tai cua chu E
	j main	
Exit:
	li $v0,10
	syscall
