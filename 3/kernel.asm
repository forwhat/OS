[bits 16]
	extern cmain
	global _start

_start:
	mov ax, cs
	mov ds, ax

	push word 0x0
	call cmain
	jmp $

	%include "functions.asm"
