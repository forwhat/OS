setInt:
	xor ax, ax
	mov es, ax
	mov word[es:20h], timer
	mov word[es:0cch], int33
	mov word[es:0d0h], int34
	mov word[es:0d4h], int35
	mov word[es:0d8h], int36

	mov ax, cs
	mov word[es:22h], ax
	mov word[es:0ceh], ax
	mov word[es:0d2h], ax
	mov word[es:0d6h], ax
	mov word[es:0dah], ax
	ret

timer:
	push ax
	push ds

	;dec byte[count]
	;jnz endtimer
	;mov byte[count], 4

	mov ax, cs
	mov ds, ax
	mov ax, 0B800h
	mov gs, ax

cp1:
	cmp byte[crt], 0
	jnz cp2
	mov byte[gs:(80*24+79)*2], '/'
	inc byte[crt]
	jmp endtimer
cp2:
	cmp byte[crt], 1
	jnz cp3
	mov byte[gs:(80*24+79)*2], '|'
	inc byte[crt]
	jmp endtimer
cp3:
	mov byte[crt], 0
	mov byte[gs:(80*24+79)*2], '\'

endtimer:
	mov al, 20h
	out 20h, al
	out 0A0h, al
	pop ds
	pop ax
	iret

	count db 1
	crt db 0

int33:
	push ax
	push bx
	push cx
	push dx
	push bp

	mov ax, cs
	mov es, ax
	mov ah, 13h
	mov al, 0
	mov bl, 0ah
	mov bh, 0
	mov dh, 07h
	mov dl, 0ah
	mov bp, int33_Msg
	mov cx, int33_MsgLen
	int 10h

	pop bp
	pop dx
	pop cx
	pop bx
	mov al, 20h
	out 20h, al
	out 0a0h, al
	pop ax
	iret

int33_Msg:
	db "This is int33_Msg..."
	int33_MsgLen equ ($-int33_Msg)

int34:
	push ax
	push bx
	push cx
	push dx
	push bp

	mov ax, cs
	mov es, ax
	mov ah, 13h
	mov al, 0
	mov bl, 0ah
	mov bh, 0
	mov dh, 07h
	mov dl, 3ah
	mov bp, int34_Msg
	mov cx, int34_MsgLen
	int 10h

	pop bp
	pop dx
	pop cx
	pop bx
	mov al, 20h
	out 20h, al
	out 0a0h, al
	pop ax
	iret

int34_Msg:
	db "I'm int34."
	int34_MsgLen equ ($-int34_Msg)

int35:
	push ax
	push bx
	push cx
	push dx
	push bp

	mov ax, cs
	mov es, ax
	mov ah, 13h
	mov al, 0
	mov bl, 0ah
	mov bh, 0
	mov dh, 12h
	mov dl, 0ah
	mov bp, int35_Msg
	mov cx, int35_MsgLen
	int 10h

	pop bp
	pop dx
	pop cx
	pop bx
	mov al, 20h
	out 20h, al
	out 0a0h, al
	pop ax
	iret

int35_Msg:
	db "Hello! Call me by int35."
	int35_MsgLen equ ($-int35_Msg)

int36:	
	push ax
	push bx
	push cx
	push dx
	push bp

	mov ax, cs
	mov es, ax
	mov ah, 13h
	mov al, 0
	mov bl, 0ah
	mov bh, 0
	mov dh, 12h
	mov dl, 36h
	mov bp, int36_Msg
	mov cx, int36_MsgLen
	int 10h

	pop bp
	pop dx
	pop cx
	pop bx
	mov al, 20h
	out 20h, al
	out 0a0h, al
	pop ax
	iret

int36_Msg:
	db "Hi! I'm int36."
	int36_MsgLen equ ($-int36_Msg)

