; Declare some external functions
;

	extern	printf

	section .data
fmt:	db	'String = %s', 10, 0
str:	db	'Test String', 0

	section .text

	global main

main:
	push	dword str
	push	dword fmt
	call	printf
	add	esp, 8

	xor	eax, eax
	xor	ecx, ecx
loop1:
	mov	al, [str+ecx]
	test	al, al
	jz	cont
	push	ax
	inc	ecx
	jmp	loop1

cont:
	xor	edx, edx

loop2:	
	pop	ax
	mov	[str+edx], al
	inc	edx
	dec	ecx
	jnz	loop2

done:
	push	dword str
	push	dword fmt
	call	printf
	add	esp, 8
	mov	eax,0
	ret
