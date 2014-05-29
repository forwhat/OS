[bits 16]

	extern upper_main
	global _start
	global getchar
	global putchar

_start:
	mov ax, cs
	mov ds, ax

	push word 0x0
	call upper_main
	retf

getchar:
	mov ah, 0
	int 16h
	pop bx
	pop cx
	push bx
	ret

putchar:
	push bp
	mov bp, sp
	mov ah, 0eh
	mov al, byte[bp+6]
	mov bx, 0
	mov sp, bp
	int 10h
	pop bp
	pop bx
	pop cx
	push bx
	ret
