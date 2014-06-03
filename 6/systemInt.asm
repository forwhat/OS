%ifndef SYSINT
%define SYSINT

	extern lowertoupper
	extern uppertolower
	extern strtonum
	extern numtostr
	extern putinplace
	global setSystemInt

setSystemInt:
	push es
	xor ax, ax
	mov es, ax
	mov word[es:84h], systemInt
	mov ax, cs
	mov word[es:86h], ax
	pop es
	ret

systemInt:
	cmp ah, 0
	je f0
	cmp ah, 1
	je f1
	cmp ah, 2
	je f2
	cmp ah, 3
	je f3
	cmp ah, 4
	je f4
	cmp ah, 5
	je f5
	jmp endSystemInt

f0:
	push bp
	mov ax, cs
	mov es, ax
	mov ah, 13h
	mov al, 0
	mov bl, 0ah
	mov bh, 0
	mov dh, 0dh
	mov dl, 26h
	mov bp, OUCH_Msg
	mov cx, OUCH_MsgLen
	int 10h
	pop bp
	jmp endSystemInt
OUCH_Msg:
	db "OUCH"
	OUCH_MsgLen equ ($-OUCH_Msg)

f1:
	push bp
	mov bp, sp
	push word 0x0
	push dx
	push word 0x0
	push es
	push word 0x0
	call lowertoupper
	mov sp, bp
	pop bp
	jmp endSystemInt

f2:	
	push bp
	mov bp, sp
	push word 0x0
	push dx
	push word 0x0
	push es
	push word 0x0
	call uppertolower
	mov sp, bp
	pop bp
	jmp endSystemInt

f3:
	push bp
	mov bp, sp
	push word 0x0
	push dx
	push word 0x0
	push es
	push word 0x0
	call strtonum
	mov sp, bp
	pop bp
	jmp endSystemInt

f4:
	push bp
	mov bp, sp
	push word 0x0
	push bx
	push word 0x0
	push dx
	push word 0x0
	push es
	push word 0x0
	call numtostr
	mov sp, bp
	pop bp
	jmp endSystemInt

f5:
	push bp
	mov bp, sp
	push word 0x0
	push cx
	push word 0x0
	push dx
	push word 0x0
	push es
	push word 0x0
	call putinplace
	mov sp, bp
	pop bp
	jmp endSystemInt

endSystemInt:
	push ax
	mov al, 20h
	out 20h, al
	out 0a0h, al
	pop ax
	iret

%endif
