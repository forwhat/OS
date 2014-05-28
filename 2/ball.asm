org 7e00h

	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ax, 0B800h
	mov gs, ax

loop:
	dec word[count]
	jnz loop
	mov word[count], delay
	dec word[dcount]
	jnz loop
	mov word[count], delay
	mov word[dcount], ddelay

	cmp word[ecount], 0
	jz endBall
	dec word[ecount]

calx:
	mov al, byte[xd]
	add byte[row], al
	cmp byte[row], 0
	jz chtodown
	cmp byte[row], 24
	jz chtoup
	jmp caly
chtodown:
	mov byte[xd], 1
	jmp caly
chtoup:
	mov byte[xd], -1
	jmp caly

caly:
	mov al, byte[yd]
	add byte[col], al
	cmp byte[col], 0
	jz chtoright
	cmp byte[col], 79
	jz chtoleft
	jmp show
chtoright:
	mov byte[yd], 1
	jmp show
chtoleft:
	mov byte[yd], -1
	jmp show

show:
	push bp
	mov ax, 0
	mov al, byte[row]
	mov bx, 80
	mul bx
	mov bx, 0
	mov bl, byte[col]
	add ax, bx
	mov bx, 2
	mul bx
	mov bp, ax
	mov ah, 0fh
	mov al, byte[Char]
	mov word[gs:bp], ax
	pop bp
	jmp loop

endBall:
	;清屏
	mov ah, 6h
	mov al, 0
	mov bh, 0
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h
	ret

datadef:
	delay equ 500
	ddelay equ 1000
	xd db 1
	yd db 1
	count dw delay
	dcount dw ddelay
	row db 0
	col db 0
	Char db '*'
	ecount dw 60

	times 510-($-$$) db 0
	dw 0aa55h
