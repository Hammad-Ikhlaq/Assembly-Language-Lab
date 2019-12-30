[org 0x0100]
jmp start
oldisr: dd 0
clrscr:
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax
	xor di, di 
	mov ax, 0x0720
	mov cx, 2000
	cld 
	rep stosw
	pop di
	pop cx
	pop ax
	pop es
	ret
kbisr: 
	pusha
	mov ax, 0xb800
	push ax 
	pop ds
	push cs
	pop es
	in al, 0x60 
	cmp al, 0x2a
	jne nextcmp
	
	xor si, si 
	mov di,savescreen
	mov cx, 2000
	cld 
	rep movsw
	 
	call clrscr
	jmp exit 
nextcmp: 
	cmp al, 0x36 
	jne nextcmp2 
	call clrscr
	jmp exit
nextcmp2: 
	cmp al, 0xaa 
	jne nextcmp3 
	mov ax, 0xb800
	push ax 
	pop es
	push cs
	pop ds
	xor di, di 
	mov si,savescreen
	mov cx, 2000
	cld 
	rep movsw

	jmp exit
nextcmp3: 
	cmp al, 0xb6 
	jne nomatch 
	mov ax, 0xb800
	push ax 
	pop es
	push cs
	pop ds
	xor di, di 
	mov si,savescreen
	mov cx, 2000
	cld 
	rep movsw
	jmp exit 
nomatch: 
	popa
	jmp far [cs:oldisr] 
exit: 
	mov al, 0x20
	out 0x20, al
	popa
	iret
start: 
	xor ax, ax
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
	mov cl, 100
	shr dx, cl 
	mov ax, 0x3100
	int 0x21
savescreen: dw 0