[org 0x0100]
jmp start
oldisr: dd 0
place: dw 158
tickcount: dw 0
delay: db 18
kbisr: 
	push ax
	push es
	push si
	push bx
	mov ax,0xb800
	mov es,ax

	mov ah,0xff
	in al, 0x60 ; read a char from keyboard port
again:	cmp al, ah ; has the left shift pressed
	je end	
	dec ah
	cmp ah,128
	ja again
	mov bh, 0x07
	mov bl,'*'
	mov si,[place]
	mov word[es:si],bx
	add word[place],160
	
end:	pop bx
	pop si
	pop es 
	pop ax	
	jmp far [cs:oldisr] ; call the original ISR

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
nextdigit: 
	mov dx, 0 
	div bx 
	add dl, 0x30 
	push dx 
	inc cx
	cmp ax, 0 
	jnz nextdigit 
	mov di, 140 
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

timer: 
	push ax
	cmp byte[delay],0
	je tick
	jmp skip
tick:	inc word [cs:tickcount]
	cmp word [cs:tickcount],6
	je retain
	jmp con
retain:
	mov word [cs:tickcount],1
	call clrscr
	mov word[place],158

con:	push word [cs:tickcount]
	call printnum 
	jmp restore
skip:	
	dec byte[delay]
	jmp exit

restore:	
	mov byte[delay],18
	
	
exit:	mov al, 0x20
	out 0x20, al 
	pop ax
	iret 
start: 
	
	call clrscr
	xor ax, ax
	mov es, ax
	mov ax, [es:9*4]
	mov [oldisr], ax ; save offset of old routine
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax
	cli
	mov word [es:9*4], kbisr
	mov [es:9*4+2], cs
	mov word [es:8*4], timer
	mov [es:8*4+2], cs 
	sti
	mov word[place],158
	mov dx, start
	add dx, 15 
	mov cl, 4
	shr dx, cl 
	mov ax, 0x3100 
	int 0x21