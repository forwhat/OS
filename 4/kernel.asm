[bits 16]
	extern cmain
	global _start

_start:
	mov ax, cs
	mov ds, ax
	mov ax, 0B800h
	mov gs, ax

	call setInt
	push word 0x0
	call cmain
	jmp $

	%include "functions.asm"
	%include "int.asm"
