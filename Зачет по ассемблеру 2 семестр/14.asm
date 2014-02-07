; Declare some external functions
;

	extern	printf

	section .data
fmt:	db	'String = %s', 10, 0
str:	db	'Test   String', 0
len:	equ $-str

	section .text

	global main

main:
	push	dword str
	push	dword fmt
	call	printf
	add	esp, 8

	xor	ecx, ecx
	xor	edx, edx
process:
	mov	al, [str+ecx]
	test	al, al
	jz	done
	inc	ecx
loop:	cmp	al, [str+ecx]
	jne	next
	inc	ecx
	jmp	loop
next:	mov	[str+edx], al
	inc	edx
	jmp	process

done:
	xor	al, al
	mov	[str+edx], al
	push	dword str
	push	dword fmt
	call	printf
	add	esp, 8
	mov	eax,0
	ret
