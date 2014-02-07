; Declare some external functions
;

	extern	printf
	extern	atoi

	section	.data

res:	dd	0
format:	db	'Res = %d', 10, 0
error:	db	'There are no command line arguments to process', 10, 0

	section .text

	global	main

main:
	mov	ecx, [esp+4]		; argc - заносим в ecx количество аргументов
	dec	ecx			; don't count program name - убираем аргумент = имени программы
	jz	nothingToProcess	; аргументов кроме имени программы больше нет
	mov	edx, [esp+8]		; argv занести в edx первый аргумент
process:
	push	ecx			; save values across call to atoi - сохранение регистров ecx и edx
	push	edx			; -/--/-
	push	dword [edx+ecx*4]	; argv[ecx] - обращение к аргументу
	call	atoi			; now eax has the int value of arg - в eax лежит численный арумент
	add	esp, 4			; сместить рамку стека
	pop	edx			; restore registers after atoi call - воссоздание значений регистров ecx и edx
	pop	ecx			; -/--/-
	imul	eax, eax		; eax *= eax
	add	[res], eax		; res += eax;
	dec	ecx			; ecx--
	jnz	process			; more arguments? - еще какие-то аргументы остались?

	push	dword [res]		; запихнуть в стек для печати
	push	format			; push format string
	call	printf			; печать
	add	esp, 8			; 4 bytes format, 8 bytes number
	ret

nothingToProcess:			; невалидный вызов
	push	error
	call	printf
	add	esp, 4
	ret
