; Declare some external functions
;
        extern	printf		; the C function, to be called

        SECTION .data		; Data section, initialized variables

a:	dd	5
b:	dd	6
res:	dd	0
fmt:    db "Res = %d", 10, 0 ; The printf format, "\n",'0'


        SECTION .text                   ; Code section.

        global main		; the standard gcc entry point
main:				; the program label for the entry point
        push    ebp		; set up stack frame
        mov     ebp,esp

	mov	eax, [a]
	mov	ebx, [b]
	imul	eax, ebx
	mov	ecx, eax
	mov	eax, [a]
	add	eax, ebx
	imul	eax, 2
	cmp	eax, ecx
	jle	ltmp1
	mov	dword [res], 1
	jmp	ltmp2
ltmp1:	mov	dword [res], -1
ltmp2:
	
        push    dword [res]	; value of variable a
        push    dword fmt	; address of ctrl string
        call    printf		; Call C function
        add     esp, 8		; pop stack 3 push times 4 bytes

        mov     esp, ebp	; takedown stack frame
        pop     ebp

	mov	eax,0		; normal, no error, return value
	ret			; return
