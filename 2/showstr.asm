org 7e00h

Start:
	mov ax, cs
	mov ds, ax
	mov es, ax

	; 显示字符串
	mov ah,13h ; 功能号
	mov al,1 ; 光标放到串尾
	mov bl,0ah ; 亮绿
	mov bh,0 ; 第0页
	mov dh,0bh ; 第11行
	mov dl,10h ; 第16列
	mov bp,Message ; BP=串地址
	mov cx,MessageLength ; 串长为9个字符
	int 10h ; 调用10H号中断

ReadKey:
	mov ah, 0
	int 16h
	cmp al, 1bh
	jz exit
	jmp ReadKey

exit:
	;清屏
	mov ah, 6h
	mov al, 0
	mov bh, 0
	mov cx, 0
	mov dh, 24
	mov dl, 79
	int 10h
	ret

Message:
	db "This is the 2nd program. Press Esc to continue."
MessageLength equ ($-Message)
