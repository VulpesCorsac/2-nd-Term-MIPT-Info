; Declare some external functions
;

	extern	printf

	section .data
fmt:	db	'Stage = %d', 10, 0
resfmt:	db	'Res = %d', 10, 0

	section .text

	global main

main:
	push	6
	call	recursion
	add	esp, 4
	push	dword eax
	push	resfmt
	call	printf
	add	esp, 8
	mov	eax,0
	ret

recursion:
        mov     eax, [esp+4]
	push	eax
	push	dword eax
	push	fmt
	call	printf
	add	esp, 8
	pop	eax
        cmp	eax, 1			; n <= 1
        jnle	L1			; if not, go do a recursive call
        mov	eax, 1			; otherwise return 1
        jmp	L2
L1:
	dec	eax			; n-1
	push	eax			; push argument
	call	recursion		; do the call, result goes in eax
	pop	ebx			; get rid of argument
	push	eax
	dec	ebx
	push	ebx
	call	recursion
	pop	ebx
	pop	ebx
	add	eax, ebx
L2:
	ret
