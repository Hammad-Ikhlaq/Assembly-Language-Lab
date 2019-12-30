
[org 0x0100]
jmp start
message1: db 'you did 0 division',0
message2: db 'quotient does not fit',0
strlen:
	push bp
	mov bp,sp
	push es
	push cx
	push di

	mov di,[bp+4]	;di contains string2
	mov cx,0xffff
	xor al,al
	repne scasb
	mov dx,0xffff
	sub dx,cx
	dec dx		;length of string2 in dx

	pop di
	pop cx
	pop es
	pop bp
	ret 4

clrscr: 
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax ; point es to video base
	xor di, di ; point di to top left column
	mov ax, 0x0720 ; space char in normal attribute
	mov cx, 2000 ; number of screen locations
	cld ; auto increment mode
	rep stosw ; clear the whole screen
	pop di
	pop cx
	pop ax
	pop es
	ret
printstr: 
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	push ds
	pop es 
	mov di, [bp+4] 
	mov cx, 0xffff
	xor al, al 
	repne scasb
	mov ax, 0xffff
	sub ax, cx 
	dec ax 
	jz exit
	mov cx, ax 
	mov ax, 0xb800
	mov es, ax 
	mov al, 80
	mul byte [bp+8] 
	add ax, [bp+10]
	shl ax, 1 
	mov di,ax 
	mov si, [bp+4]
	mov ah, [bp+6] 
	cld
	nextchar: 
	lodsb 
	stosw 
	loop nextchar 
	exit: pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 8
myisrfor0:
	push ax 
	push bx
	push cx
	push dx
	push si
	push di
	push bp
	push ds
	push es
	push cs
	pop ds 
	call clrscr 
	mov ax, 30
	push ax 
	mov ax, 20
	push ax 
	mov ax, 0x71 
	push ax 
	mov ax, message1
	push ax 
	call printstr 
	pop es
	pop ds
	pop bp
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
myisr:
	push ax 
	push bx
	push cx
	push dx
	push si
	push di
	push bp
	push ds
	push es
	push cs
	pop ds 
	call clrscr 
	mov ax, 30
	push ax 
	mov ax, 20
	push ax 
	mov ax, 0x71 
	push ax 
	mov ax, message2
	push ax 
	call printstr 
	pop es
	pop ds
	pop bp
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax

	pop dx
	add dx,1
	push dx
	iret
genint0: 
	mov ax, 0x8432 
	mov bl, 2
	cmp bl,0
	je myisrfor0
	div bl 
	ret
start: 
	xor ax, ax
	mov es, ax 
	mov word [es:0*4], myisr 
	mov [es:0*4+2], cs 
	call genint0
mov ax, 0x4c00 
int 0x21