[bits 16]
	extern test_main
	global _start

_start:
	mov ax, cs
	mov ds, ax
	push word 0x0
	call test_main
	jmp $

	%include "string.asm"
	%include "fork.asm"
	%include "semaphore.asm"
