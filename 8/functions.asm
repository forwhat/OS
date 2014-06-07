	extern hour
	extern min
	extern sec
	extern century
	extern year
	extern month
	extern day
	
	global getTime
	global getDate
	global loadSector
	global cls
	global CCLI
	global CSTI
	global JUMP

getTime:
	mov ah, 02h
	int 1ah
	xor ax, ax
	mov al, ch
	mov word[hour], ax
	mov al, cl
	mov word[min], ax
	mov al, dh
	mov word[sec], ax
	jmp Creturn

getDate:
	mov ah, 04h
	int 1ah
	xor ax, ax
	mov al, ch
	mov word[century], ax
	mov al, cl
	mov word[year], ax
	mov al, dh
	mov word[month], ax
	mov al, dl
	mov word[day], ax
	jmp Creturn

loadSector:
	push bp
	mov bp, sp
	mov ax, word[bp+18]
	mov es, ax
	mov ah, 2
	mov al, byte[bp+22]
	mov bx, 0h
	mov ch, byte[bp+10]
	mov cl, byte[bp+14]
	mov dh, byte[bp+6]
	mov dl, 0
	int 13h
	mov sp, bp
	pop bp
	jmp Creturn

CCLI:
	cli
	jmp Creturn

CSTI:
	sti
	jmp Creturn

JUMP:
	call 6000h:0
	mov ax, cs
	mov ds, ax
	jmp Creturn

cls:
	mov ah, 0
	mov al, 3
	int 10h
	jmp Creturn

Creturn:
	pop bx
	pop cx
	push bx
	ret

