%ifndef FORK
%define FORK

	global fork
	global wait0
	global exit

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
	push bp
	mov bp, sp
	mov al, byte[bp+6]
	mov ah, 8
	int 21h
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

%endif
