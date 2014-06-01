[bits 16]

	extern test_main
	global _start
	global test0
	global test1
	global test2
	global test3
	global test4
	global test5

_start:
	mov ax, cs
	mov ds, ax

	push word 0x0
	call test_main
	retf

	%include "string.asm"

test0:
	mov ah, 0
	int 21h
	jmp gccreturn

test1:
	push bp
	mov bp, sp
	mov ah, 1
	mov dx, word[bp+10]
	mov es, word[bp+6]
	int 21h
	mov sp, bp
	pop bp
	jmp gccreturn

test2:
	push bp
	mov bp, sp
	mov ah, 2
	mov dx, word[bp+10]
	mov es, word[bp+6]
	int 21h
	mov sp, bp
	pop bp
	jmp gccreturn

test3:
	push bp
	mov bp, sp
	mov ah, 3
	mov dx, word[bp+10]
	mov es, word[bp+6]
	int 21h
	mov sp, bp
	pop bp
	jmp gccreturn

test4:
	push bp
	mov bp, sp
	mov ah, 4
	mov bx, word[bp+14]
	mov dx, word[bp+10]
	mov es, word[bp+6]
	int 21h
	mov sp, bp
	pop bp
	jmp gccreturn

test5:
	push bp
	mov bp, sp
	mov ah, 5
	mov es, word[bp+6]
	mov dx, word[bp+10]
	mov ch, byte[bp+14]
	mov cl, byte[bp+18]
	int 21h
	mov sp, bp
	pop bp
	jmp gccreturn

gccreturn:
	pop bx
	pop cx
	push bx
	ret
