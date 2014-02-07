; Declare some external functions
;

	extern	printf
	extern	atoi

	section	.data

res:	dd	1
format:	db	'Res = %d', 10, 0
error:	db	'There are no command line arguments to process', 10, 0

	section .text

	global	main

main:
	mov	ecx, [esp+4]		; argc
	dec	ecx			; don't count program name
	jz	nothingToProcess
	mov	edx, [esp+8]		; argv
process:
	push	ecx			; save values across call to atoi
	push	edx
	push	dword [edx+ecx*4]	; argv[ecx]
	call	atoi			; now eax has the int value of arg
	add	esp, 4
	pop	edx			; restore registers after atoi call
	pop	ecx
	imul	eax, [res]
	mov	[res], eax
	dec	ecx
	jnz	process			; more arguments?

	push	dword eax
	push	format			; push format string
	call	printf
	add	esp, 8			; 4 bytes format, 8 bytes number
	ret

nothingToProcess:
	push	error
	call	printf
	add	esp, 4
	ret
