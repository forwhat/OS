[bits 16]

	extern test2_main
	global _start

_start:
	mov ax, cs
	mov ds, ax
	push word 0x0
	call test2_main
	jmp $
	
	%include "string.asm"
	%include "fork.asm"
	%include "semaphore.asm"
