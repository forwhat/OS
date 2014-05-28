org 7c00h

Start:
	mov ax, cs
	mov ds, ax
	mov es, ax

	mov bp, Message
	mov cx, MessageLength
	mov ax, 1301h
	mov bx, 0007h
	mov dx, 0
	int 10h

ReadKey:
	mov ah, 0
	int 16h
	mov ah, 0eh
	mov bl, 0
	int 10h
	cmp al, 0dh
	jnz addtoqueue
	jmp Load

addtoqueue:
	sub al, 2fh
	mov bx, 0
	mov bl, byte[cnt]
	add bx, queue
	mov byte[bx], al
	inc byte[cnt]
	jmp ReadKey

Load:
	mov bx, 0
	mov bl, byte[pointer]
	cmp bl, byte[cnt]
	jz Reload
	add bx, queue
	mov cl, byte[bx]
	inc byte[pointer]

	mov ax, cs
	mov es, ax
	mov bx, OffsetOfUserPrg
	mov ah, 2
	mov al, 1
	mov dl, 0
	mov dh, 0
	mov ch, 0
	int 13h

	;清屏
	mov ah, 6h
	mov al, 0
	mov bh, 0
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h

	call OffsetOfUserPrg
	jmp Load

Reload:
	mov byte[pointer], 0
	mov byte[cnt], 0
	jmp 7c00h

Message:
	db 'Press keys(between 1 and 3): '
MessageLength equ ($-Message)
OffsetOfUserPrg equ 7e00h

datadef:
	pointer db 0
	cnt db 0
	queue db 0
	
	times 510-($-$$) db 0
	dw 0aa55h
