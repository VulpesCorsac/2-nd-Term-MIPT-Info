; Declare some external functions
;
        extern printf                   ; the C function to be called

        SECTION .data                   ; Data section
fmt:    db "Res = %d", 10, 0 ; The printf format, "\n",'0'

	global	main
	
	section .text
main:
	push	8
	push	7
	push	15
	push	3
	call	sum
	add	esp, 16

	push	dword eax
	push	dword fmt
	call	printf
	add	esp, 8
	ret

sum:
	mov	ecx, [esp+4]		; length of array
	mov     edx, 8                  ; address of first element
	mov	eax, 0			; initial value
	cmp	ecx, 0			; guard against non-positive lengths!
	jle	done
next:
	add	eax, [esp+edx]
	add	edx, 4
	dec	ecx
	jnz	next
done:
	ret              		; return value already in eax
