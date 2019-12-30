
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
key:	mov ah,0
	int 0x16
	mov bl,al	

		
	call clrscr 

	mov ax,[old]
	mov [es:33*4],ax
	mov ax,[old+2]		;unhooking
	mov [es:33*4+2],ax

	cmp bl,'q'
	je exit1
	cmp bl,'d'
	je first
	cmp bl,'t'
	je second
	jmp key

first:	mov AH, 2ah
	int 21h
	mov di, 320 	; point di to top left column
	mov bl,dl
	mov bh,0
	push bx
	call printnum
	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	mov bl,dh
	mov bh,0
	push bx
	call printnum
	mov bx,cx
	push cx
	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	call printnum
	jmp key
exit1:	jmp e
second:	mov AH, 2ch
	int 21h
	mov di, 160 	; point di to top left column
	mov bl,ch
	mov bh,0
	push bx
	call printnum
	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	add di,2
	mov bl,cl
	mov bh,0
	push bx
	call printnum
	mov bl,dh
	mov bh,0
	push bx
	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	call printnum
	jmp key
	
exit:	mov word [es:33*4], myisr  
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
	add ax,4
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
	push si
	mov ax, 0xb800
	mov es, ax ; point es to video base
	mov ax, [bp+4] ; load number in ax
	mov bx, 10
	mov cx, 0 ; initialize count of digits
nextdigit:
	mov dx, 0 ; zero upper half of dividend
	div bx ; divide by 10
	cmp dl,10
	jb chr

hex:	mov si,ax	;saving ax i.e prev value
	mov dh, 0 	; zero upper half of dividend
	mov ax,dx	;dividing the sub num
	div bx 		; divide by 10
	add dl, 0x30 
	push dx
	add al, 0x30
	push ax
	mov ax,si
	jmp nextdigit
	
chr:	add dl, 0x30 
	push dx ; save ascii value on stack
	inc cx ; increment count of values
	cmp ax, 0 ; is the quotient zero
	jnz nextdigit ; if no divide it again
	
nextpos: 
	pop dx ; remove a digit from the stack
	mov dh, 0x07 ; use normal attribute
	mov [es:di], dx ; print char on screen
	add di, 2 ; move to next screen location
	loop nextpos ; repeat for all digits on stack
	pop si
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
e:
mov ax,0x4c00
int 21h