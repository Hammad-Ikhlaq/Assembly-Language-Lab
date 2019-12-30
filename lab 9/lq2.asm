
[org 0x0100]
jmp start
old: dw 0,0 

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

	mov ax,[old]
	mov [es:33*4],ax
	mov ax,[old+2]
	mov [es:33*4+2],ax
	mov AH, 2ah
	int 21h

	mov bh,dl
	mov bl,0
	push bx
	mov bh,dh
	mov bl,0
	push bx
	mov bx,cx
	push cx
	call printnum

	mov word [es:33*4], myisr  
	mov [es:33*4+2], cs 

	pop es
	pop ds
	pop bp
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	
	pop ax
	add ax,2
	push ax
	iret
printnum: 
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	mov ax, 0xb800
	mov es, ax 	
	mov ax, [bp+4] 	
	mov bx, 10	
	mov cx, 0 	
nextdigit1:
	mov dx, 0 	
	div bx 	
	add dl, 0x30 	
	push dx 	
	inc cx 	
	cmp ax, 0 	
	jnz nextdigit1	
	mov di, 0 
	
nextpos1:
	pop dx 	
	mov dh, 0x07 	
	mov [es:di], dx 	
	add di, 2 	
	loop nextpos1	

	mov ax, [bp+6] 	
	mov bx, 10	
	mov cx, 0 	
nextdigit2:
	 mov dx, 0 	
	div bx 	
	add dl, 0x30 	
	push dx 	
	inc cx 	
	cmp ax, 0 	
	jnz nextdigit2	
	mov di, 160
	
nextpos2:
	pop dx 	
	mov dh, 0x07 	
	mov [es:di], dx 	
	add di, 2 	
	loop nextpos2 

	mov ax, [bp+8] 	
	mov bx, 10	
	mov cx, 0 	
nextdigit3: mov dx, 0 	
	div bx 	
	add dl, 0x30 	
	push dx 	
	inc cx 	
	cmp ax, 0 	
	jnz nextdigit3	
	mov di, 320 
	
nextpos:
	pop dx 	
	mov dh, 0x07 	
	mov [es:di], dx 	
	add di, 2 	
	loop nextpos 
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 2
genint: 

	mov AH, 2ah
	int 21h
	ret 
start: 
	xor ax, ax
	mov es, ax
	mov bx, [es:33*4]
	mov [old],bx
	mov bx, [es:33*4+2]
	mov [old+2],bx	
	
	mov word [es:33*4], myisr  
	mov [es:33*4+2], cs 
	call genint
mov ax, 0x4c00 
int 0x21