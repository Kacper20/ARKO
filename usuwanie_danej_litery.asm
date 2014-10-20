	.data
welcome: .asciiz "Enter a string: "
buf: .space 80  # 80 element char array

	.text
	.globl main

main:
	la $a0, welcome 
	li $v0, 4
	syscall
	#pod a0 ladujemy buff, pod a1 ladujemy wielkosc bufora.
	la $a0, buf
	li $a1, 80
	li $v0, 8
	syscall

#znak ktory bedzie usuwany	li	$t3,	'b'
#t1 - wskaznik czytajacy, t2 - wskaznik piszacy.
#t0 - wartosc znaku, ktory jest wskazywany przez wskaznik czytajacy.
	li $t3, 'b'
	la $t1, buf
	la $t2, buf
next:
	#t1 to adres
	lbu $t0, ($t1)
	blt $t0, ' ', fin # jak czytajacy jest juz na koncuuu - procedura finalna
	beq $t0, $t3, to_delete
	#na czytajacym jest znak dozwolony - piszemy go na piszacym
	sb	$t0,	0($t2)	
	#przechodzimy obydwoma w prawo
	addiu	$t1,	$t1,	1
	addiu	$t2,	$t2,	1
	b 	next

to_delete:
	#przesuwamy czytajacy, bo obecny znak mamy usunac.
	addiu	$t1,	$t1,	1
	b next
	
fin:
	#czyszczenie(wpisanie \n i \0)
	li	$t0,	10
	sb	$t0,	($t2)
	addiu	$t2,	$t2,	1
	li	$t0,	0
	sb	$t0,	($t2)
	#wypisuje buff
	la $a0, buf
	li $v0, 4
	syscall
	#Exit - konczenie
	li $v0, 10
	syscall
