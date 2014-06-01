[bits 16]
	mov ax, cs
	mov ds, ax
	mov ax, 0B800h
	mov gs, ax

	xor ax,ax				    ; AX = 0
	mov es,ax					; ES = 0
	push word[es:024h]
	pop word[t1]
	push word[es:026h]
	pop word[t2]
	mov word[es:024h],Keyboard
	mov ax,cs
	mov [es:026h],ax				; 设置时钟中断向量的段地址=CS
	
loop:
	dec word[count]				; 递减计数变量
	jnz loop				; >0：跳转;
	mov word[count],delay
	dec word[dcount]				; 递减计数变量
    jnz loop
	mov word[count],delay
	mov word[dcount],ddelay
	
	cmp word[cnt],0
	jz endball
	dec word[cnt]
	
calx:
	mov al,byte[xd]
	add byte[row],al
	cmp byte[row],0
	jz chtodown
	cmp byte[row],24
	jz chtoup
	jmp caly
chtodown:
	mov byte[xd],1
	jmp caly
chtoup:
	mov byte[xd],-1
	jmp caly
	
caly:
	mov al,byte[yd]
	add byte[col],al
	cmp byte[col],0
	jz chtoright
	cmp byte[col],79
	jz chtoleft
	jmp show
chtoright:
	mov byte[yd],1
	jmp show
chtoleft:
	mov byte[yd],-1
	jmp show
	
show:
	push bp
    mov ax, 0
    mov al, byte [row]
    mov bx, 80
    mul bx
    mov bx, 0
    mov bl, byte [col]
    add ax, bx
    mov bx, 2
    mul bx
    mov bp, ax
    mov ah, 0fh
    mov al, byte[Char]
    mov word [gs:bp], ax
	pop bp
    jmp loop
	
endball:
	xor ax,ax
	mov es,ax
	push word[t1]
	pop word[es:024h]
	push word[t2]
	pop word[es:026h]
	retf

Keyboard:
	push ax
	push bp
	
	in al,60h
	mov bp,[pos]
	mov byte[gs:bp],'O'
	add word[pos],2
	mov bp,[pos]
	mov byte[gs:bp],'U'
	add word[pos],2
	mov bp,[pos]
	mov byte[gs:bp],'C'
	add word[pos],2
	mov bp,[pos]
	mov byte[gs:bp],'H'
	add word[pos],2
	mov bp,[pos]
	mov byte[gs:bp],'!'
	add word[pos],2
	mov al,20h					; AL = EOI
	out 20h,al						; 发送EOI到主8529A
	out 0A0h,al					; 发送EOI到从8529A
	pop bp
	pop ax
	iret

datadef:
	delay equ 500
	ddelay equ 1000
	xd db 1
	yd db 1
	count dw delay
	dcount dw ddelay
	color db 0
	cnt dw 90
	row db 0
	col db 0
	pos dw 0
	Char db 'A'
	t1 dw 0
	t2 dw 0

