; Declare some external functions
;

	extern	printf

	section .data
fmt:	db	'String = %s', 10, 0
str:	db	'Test String', 0
len:	equ $-str

	section .text

	global main

main:
	push	dword str
	push	dword fmt
	call	printf
	add	esp, 8

	xor	ecx, ecx
process:
	mov	al, [str+ecx]
	test	al, al
	jz	done
	cmp	al, 97
	jl	next
	cmp	al, 122
	jg	next
	sub	al, 32
next:	mov	[str+ecx], al
	inc	ecx
	jmp	process

done:
	push	dword str
	push	dword fmt
	call	printf
	add	esp, 8
	mov	eax,0
	ret
