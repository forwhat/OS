%ifndef SYSINT
%define SYSINT

	extern lowertoupper
	extern uppertolower
	extern strtonum
	extern numtostr
	extern putinplace
	extern do_fork
	extern do_wait
	extern do_exit
	global setSystemInt
	global memcopy

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
	cli
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
	cmp ah, 6
	je f6
	cmp ah, 7
	je f7
	cmp ah, 8
	je f8
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

f6:
	call Save
	push word 0x0
	call do_fork
	call Restart
	jmp endSystemInt

f7:
	call Save
	push word 0x0
	call do_wait
	call Restart
	jmp endSystemInt

f8:
	call Save
	push word 0x0
	call do_exit
	call Restart
	jmp endSystemInt

endSystemInt:
	push ax
	mov al, 20h
	out 20h, al
	out 0a0h, al
	pop ax
	sti
	iret

memcopy:
	push bp
	mov bp, sp
	push di
	push si
	push es
	push ds
	push cs
	pop ds
	mov di, word[ds:sp_save]
	mov si, word[ds:sp_save]
	mov bx, word[bp+6]
	mov es, bx
	mov cx, word[bp+10]
	push ss
	pop ds

copyLoop:
	mov al, byte[ds:di]
	mov byte[es:si], al
	inc di
	inc si
	loop copyLoop

endCopy:
	pop ds
	pop es
	pop si
	pop di
	mov sp, bp
	pop bp
	pop bx
	pop cx
	push bx
	ret

%endif
