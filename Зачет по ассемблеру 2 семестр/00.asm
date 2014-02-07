; Declare some external functions
;
        extern	printf		; the C function, to be called

        SECTION .data		; Data section, initialized variables

a:	dd	5
b:	dd	-1
c:	dd	8
fmt:    db "Res = %d", 10, 0 ; The printf format, "\n",'0'


        SECTION .text                   ; Code section.

        global main		; the standard gcc entry point
main:				; the program label for the entry point
        push    ebp		; set up stack frame
        mov     ebp,esp

	push	dword [a]
	push	dword [b]
	push	dword [c]
	call	maxofthree
	add	esp, 12
	
        push    dword eax	; value of variable
        push    dword fmt	; address of ctrl string
        call    printf		; Call C function
        add     esp, 8

        mov     esp, ebp	; takedown stack frame
        pop     ebp

	mov	eax,0		; normal, no error, return value
	ret			; return

maxofthree:
	mov	eax, [esp+4]
	mov	ecx, [esp+8]
	mov	edx, [esp+12]
	cmp	eax, ecx
	cmovl	eax, ecx
	cmp	eax, edx
	cmovl	eax, edx
	ret
