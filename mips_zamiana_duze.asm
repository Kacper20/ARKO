	.data
welcome: .asciiz "Enter a string: "
buf: .space 80  # 80 element char array

#t1: wskaznik na poczatek pliku
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
	
	#32 to nasze przesuniecie, zeby zamieniac DUZE->MALE (Tabela ASCII)
	la $t1, buf
	li $t0, 32 # do t0 ladujemy nasza gwiazdke ktora mamy podstawiac
next:
	#t1 to adres, pod tym adresem jest bajt - bierzemy go
	lbu $t2, ($t1) 
	# jak mniejszy od spacji - wypisujemy, koniec
	bltu $t2, ' ', fin
	bltu $t2, 'A', nochg
	bgtu $t2, 'Z', nochg
	addiu	$t2,	$t2,	32
	sb	$t2,	($t1)
			
	#sb $t0, ($t1) # na pewno to liczba - podstawiamy t0 za bajt na ktorym jest obecnie t1
nochg:
	addiu $t1, $t1, 1
	b next


	#przetwarzanie
fin:
	la $a0, buf
	li $v0, 4
	syscall
	
	#Exit - konczenie
	li $v0, 10
	syscall
