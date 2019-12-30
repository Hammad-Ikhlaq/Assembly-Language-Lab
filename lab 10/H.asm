
[org 0x0100]
jmp start
old: dw 0,0 
day: dw 0
month: dw 0
year: dw 0
hour: dw 0
min: dw 0
sec:dw 0

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
	mov [day],bx
	mov bl,dh
	mov bh,0
	mov [month], bx
	mov bx,cx
	mov [year], cx
	
mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0A03 ; row 10 column 3
mov cx, 2 ; length of string
push cs
pop es ; segment of string
mov bp, day ; offset of string
int 0x10 ; call BIOS video service


	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2

	mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0A03 ; row 10 column 3
mov cx, 2 ; length of string
push cs
pop es ; segment of string
mov bp, month ; offset of string
int 0x10 ; call BIOS video service

	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0A03 ; row 10 column 3
mov cx, 2 ; length of string
push cs
pop es ; segment of string
mov bp, year ; offset of string
int 0x10 ; call BIOS video service
exit1:	jmp e
second:	mov AH, 2ch
	int 21h
	mov di, 160 	; point di to top left column
	mov bl,ch
	mov bh,0
	mov [hour],bx
	mov bl,cl
	mov bh,0
	mov [min], bx
	mov bl,dh
	mov bh,0
	mov [sec],bx
	mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0A03 ; row 10 column 3
mov cx, 2 ; length of string
push cs
pop es ; segment of string
mov bp, hour ; offset of string
int 0x10 ; call BIOS video service
	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	

	mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0A03 ; row 10 column 3
mov cx, 2 ; length of string
push cs
pop es ; segment of string
mov bp, min ; offset of string
int 0x10 ; call BIOS video service

	mov bh,7
	mov bl,'/'
	mov [es:di],bx
	add di,2
	mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0A03 ; row 10 column 3
mov cx, 2 ; length of string
push cs
pop es ; segment of string
mov bp, sec ; offset of string
int 0x10 ; call BIOS video service
	jmp e
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