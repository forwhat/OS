Start:
	mov ax, cs
	mov ds, ax

	mov ax, 0B800h
	mov gs, ax

rollLoop:
	dec word[count]
	jnz rollLoop
	mov word[count], delay
	dec word[dcount]
	jnz rollLoop
	mov word[count], delay
	mov word[dcount], ddelay

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
	
	mov al, byte[dir]
	cmp al, 1
	je goRight
	cmp al, 2
	je goDown
	cmp al, 3
	je goLeft
	jmp goUp

goRight:
	inc byte[col]
	cmp byte[col], 39
	jnz rollLoop
	mov byte[dir], 2
	jmp rollLoop

goDown:
	inc byte[row]
	cmp byte[row], 12 
	jnz rollLoop
	mov byte[dir], 3
	jmp rollLoop

goLeft:
	dec byte[col]
	cmp byte[col], 0
	jnz rollLoop
	mov byte[dir], 4
	jmp rollLoop

goUp:
	dec byte[row]
	cmp byte[row], 1
	jnz rollLoop
	mov byte[dir], 1
	inc byte[Char]
	jmp rollLoop

endRoll:
	;清屏
	mov ah, 6h
	mov al, 0
	mov bh, 0
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h
	retf

datadef:
	delay equ 100
	ddelay equ 500
	count dw delay
	dcount dw ddelay
	dir db 1
	row db 1
	col db 0
	Char db 'A'
