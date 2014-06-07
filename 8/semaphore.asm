%ifndef SEMAPHORE
%define SEMAPHORE

	global SemaGet
	global SemaFree
	global P
	global V

SemaGet:
	push bp
	mov bp, sp
	push ds
	mov cx, word[bp+6]
	mov ah, 9
	int 21h
	pop ds
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

SemaFree:
	push bp
	mov bp, sp
	push ds
	mov cx, word[bp+6]
	mov ah, 10
	int 21h
	pop ds
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

P:
	push bp
	mov bp, sp
	mov cx, word[bp+6]
	mov ah, 11
	int 21h
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

V:
	push bp
	mov bp, sp
	mov cx, word[bp+6]
	mov ah, 12
	int 21h
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

%endif
