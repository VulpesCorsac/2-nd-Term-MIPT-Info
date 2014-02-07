; Declare some external functions
;

	extern	printf
	extern	atoi

	section	.data

count:	dd	0
sum:	dd	0
format:	db	'%.15f', 10, 0
error:	db	'There are no command line arguments to average', 10, 0

	section .text

	global	main

main:
	mov	ecx, [esp+4]		; argc
	dec	ecx			; don't count program name
	jz	nothingToAverage
	mov	[count], ecx		; save number of real arguments
	mov	edx, [esp+8]		; argv
accumulate:
	push	ecx			; save values across call to atoi
	push	edx
	push	dword [edx+ecx*4]	; argv[ecx]
	call	atoi			; now eax has the int value of arg
	add	esp, 4
	pop	edx			; restore registers after atoi call
	pop	ecx
	add	[sum], eax
	dec	ecx
	jnz	accumulate		; more arguments?
average:
	fild	dword [sum]
	fild	dword [count]
	fdivp	st1, st0		; sum / count
	sub	esp, 8			; make room for quotient on stack
	fstp	qword [esp]		; "push" quotient
	push	format			; push format string
	call	printf
	add	esp, 12			; 4 bytes format, 8 bytes number
	ret

nothingToAverage:
	push	error
	call	printf
	add	esp, 4
	ret
