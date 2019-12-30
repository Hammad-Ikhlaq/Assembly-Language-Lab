[org 0x0100]
jmp start
oldisr: dd 0
scrollup:
	push bp
	mov bp,sp
	push ax
	push cx
	push si
	push di
	push es
	push ds
	mov ax, 80 
	mul byte [bp+4] 
	mov si, ax 
	push si
	shl si, 1 
	mov cx, 2000 
	sub cx, ax 
	mov ax, 0xb800
	mov es, ax
	mov ds, ax 
	xor di, di
	cld 
	rep movsw
	mov ax, 0x0720 
	pop cx 
	rep stosw
	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop ax
	pop bp
	ret 2
scrolldown:
	push bp
	mov bp,sp
	push ax
	push cx
	push si
	push di
	push es
	push ds

	mov ax, 80 
	mul byte [bp+4]
	push ax 
	shl ax, 1
	mov si, 3998
	sub si, ax
	mov cx, 2000 
	sub cx, ax
	mov ax, 0xb800
	mov es, ax 
	mov ds, ax 
	mov di, 3998 
	std 
	rep movsw 
mov ax, 0xb800
mov es, ax ; point es to video base
mov ds, ax ; point ds to video base
mov cx,80
mov si,0
mov di,160
cld
rep movsw
	mov ax, 0x0720 
	mov di,0
	pop cx 
	cld
	rep stosw 
	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop ax
	pop bp
	ret 2
kbisr: 
	pusha
	mov dx, 0xb800
	push cs
	pop es
	push dx
	pop ds
	in al, 0x60 
	cmp al, 0x2a
	jne nextcmp 

	mov di,savescreen
	mov cx,80
	mov si,0
 	cld 
	rep movsw

	mov bx,1
	push bx
	call scrollup
	mov dx, 0xb800
	push cs
	pop ds
	push dx
	pop es
	
	mov si,savescreen
	mov cx,80
	mov di,3840
 	cld 
	rep movsw
	jmp exit 
nextcmp: 
	cmp al, 0x36 
	jne nextcmp2

	mov dx, 0xb800
	push cs
	pop es
	push dx
	pop ds

	mov di,savescreen
	mov cx,80
	mov si,3840
 	cld 
	rep movsw

	mov bx,1
	push bx
	call scrolldown
	mov dx, 0xb800
	push cs
	pop ds
	push dx
	pop es
	
	mov si,savescreen
	mov cx,80
	mov di,0
 	cld 
	rep movsw
	jmp exit
nextcmp2: 
	cmp al, 0xaa 
	jne nextcmp3 
	jmp exit
nextcmp3: 
	cmp al, 0xb6 
	jne nomatch 
	jmp exit 
nomatch: 
	popa
	jmp far [cs:oldisr] 
exit: 
	mov al, 0x20
	out 0x20, al
	popa
	iret
start: xor ax, ax
	mov es, ax
	mov ax, [es:9*4]
	mov [oldisr], ax 
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax 
	cli 
	mov word [es:9*4], kbisr 
	mov [es:9*4+2], cs 
	sti 
	mov dx, start 
	add dx, 15 
	mov cl, 4
	shr dx, cl 
	mov ax, 0x3100 
	int 0x21
savescreen: dw 0