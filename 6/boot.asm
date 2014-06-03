org 7c00h

	mov ax, cs
	mov ds, ax
	
	;读软盘或硬盘上的Kernel到内存的ES:BX处：
	mov ax, SegOfKernel     ;段地址 ; 存放数据的内存基地址
	mov es,ax               ;设置段地址（不能直接mov es,段地址）
	mov bx, OffsetOfKernel  ;偏移地址; 存放数据的内存偏移地址
	mov ah,2                ;功能号
	mov al, BlockOfKernel   ;扇区数
	mov dl,0                ;驱动器号 ; 软盘为0，硬盘和U盘为80H
	mov dh,0                ;磁头号 ; 起始编号为0
	mov ch,0                ;柱面号 ; 起始编号为0
	mov cl,2                ;起始扇区号 ; 起始编号为1
	int 13H                 ;调用中断
	;内核已加载到指定内存区域中

	jmp SegOfKernel:OffsetOfKernel
	jmp $

	OffsetOfKernel  equ 0
	SegOfKernel    equ 0x1000        ;第二个64k内存的段地址(64*1024/16)  
	BlockOfKernel equ 20           ;内核占用扇区数

	times 510-($-$$)	db	0	   ;用0填充引导扇区剩下的空间
	db 	55h, 0aah				   ;引导扇区结束标志
	
