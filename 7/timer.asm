%ifndef TIMER
%define TIMER

	extern ax_save
	extern bx_save
	extern cx_save
	extern dx_save
	extern cs_save
	extern ds_save
	extern es_save
	extern gs_save
	extern ss_save
	extern sp_save
	extern bp_save
	extern si_save
	extern di_save
	extern ip_save
	extern flag_save
	extern ret_save
	extern Scheduler

	global Set_Timer
	global Recover_Timer

Set_Timer:
	mov al, 34h
	out 43h, al
	mov ax, 1193182/20
	out 40h, al
	mov al, ah
	out 40h, al
	xor ax, ax
	mov es, ax
	push word[es:20h]
	pop word[t1_save]
	push word[es:22h]
	pop word[t2_save]
	mov word[es:20h], timer
	mov ax, cs
	mov word[es:22h], ax
	pop bx
	pop cx
	push bx
	ret

Recover_Timer:
	xor ax, ax
	mov es, ax
	push word[t1_save]
	pop word[es:20h]
	push word[t2_save]
	pop word[es:22h]
	pop bx
	pop cx
	push bx
	ret

timer_save:
	t1_save dw 0
	t2_save dw 0

timer:
	call Save
	push word 0x0
	call Scheduler
	mov al, 20h
	out 20h, al
	out 0a0h, al
	call Restart
	iret

Save:
	push ds
	push cs
	pop ds
	pop word[ds:ds_save]
	pop word[ds:ret_save]
	pop word[ds:ip_save]
	pop word[ds:cs_save]
	pop word[ds:flag_save]
	mov word[ds:ax_save], ax
	mov word[ds:bx_save], bx
	mov word[ds:cx_save], cx
	mov word[ds:dx_save], dx
	mov word[ds:es_save], es
	mov word[ds:ss_save], ss
	mov word[ds:sp_save], sp
	mov word[ds:bp_save], bp
	mov word[ds:si_save], si
	mov word[ds:di_save], di
	mov word[ds:gs_save], gs
	push word[ds:ret_save]
	ret

Restart:
	pop word[ds:ret_save]
	mov ax, word[ds:ax_save]
	mov bx, word[ds:bx_save]
	mov cx, word[ds:cx_save]
	mov dx, word[ds:dx_save]
	mov es, word[ds:es_save]
	mov ss, word[ds:ss_save]
	mov sp, word[ds:sp_save]
	mov bp, word[ds:bp_save]
	mov si, word[ds:si_save]
	mov di, word[ds:di_save]
	mov gs, word[ds:gs_save]
	push word[ds:flag_save]
	push word[ds:cs_save]
	push word[ds:ip_save]
	push word[ds:ret_save]
	push word[ds:ds_save]
	pop ds
	ret

%endif
