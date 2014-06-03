[bits 16]
	extern cmain
	global _start

_start:
	mov ax, cs
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov ax, 0xffff
	mov sp, ax

	call setSystemInt
	push word 0x0
	call cmain
	jmp $

	%include "functions.asm"
	%include "string.asm"
	%include "systemInt.asm"
	%include "timer.asm"
