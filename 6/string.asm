%ifndef STRING
%define STRING

	global getchar
	global putchar
	global putcharinplace

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

putcharinplace:
	push bp
	mov bp, sp
	push si
	mov ax, 0B800h
	mov gs, ax
	mov ah, byte[bp+10]
	mov bx, word[bp+6]
	mov si, bx
	mov byte[gs:si], ah
	pop si
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

%endif
