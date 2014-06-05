[bits 16]
	extern test_main
	global _start
	global fork
	global wait0
	global exit
	global numtostr

_start:
	mov ax, cs
	mov ds, ax
	push word 0x0
	call test_main
	retf

	%include "string.asm"

fork:
	mov ah, 6
	int 21h
	pop bx
	pop cx
	push bx
	ret

wait0:
	mov ah, 7
	int 21h
	pop bx
	pop cx
	push bx
	ret

exit:
	mov ah, 8
	int 21h
	pop bx
	pop cx
	push bx
	ret

numtostr:
	push bp
	mov bp, sp
	mov ah, 4
	mov bx, word[bp+14]
	mov dx, word[bp+10]
	mov es, word[bp+6]
	int 21h
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret
