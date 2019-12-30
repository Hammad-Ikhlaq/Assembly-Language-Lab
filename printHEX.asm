[org 0x0100]
jmp start
clrscr: 
	push es
	push ax
	push di
	mov ax, 0xb800
	mov es, ax ; point es to video base
	mov di, 0 ; point di to top left column
nextloc: 
	mov word [es:di], 0x0720 ; clear next char on screen
	add di, 2 ; move to next screen location
	cmp di, 4000 ; has the whole screen cleared
	jne nextloc ; if no clear next position
	pop di
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
	mov es, ax ; point es to video base
	mov ax, [bp+4] ; load number in ax
	mov bx, 16
	mov cx, 0 ; initialize count of digits
nextdigit:
	mov dx, 0 ; zero upper half of dividend
	div bx ; divide by 16
	cmp dl,10
	jb continue
	cmp dl,10
	je a
	jmp check1
a:	
	mov dx, 41h
	jmp chr

check1:	cmp dl,11
	je b
	jmp check2
b:	
	mov dx, 42h
	jmp chr
check2:	cmp dl,12
	je c
	jmp check3
c:	
	mov dx, 43h
	jmp chr
check3:	cmp dl,13
	je d
	jmp check4
d:	
	mov dx, 44h
	jmp chr
check4:	cmp dl,14
	je e
	jmp check5
e:	
	mov dx, 45h
	jmp chr
check5:	cmp dl,15
	je f
	jmp chr
f:	
	mov dx, 46h
	jmp chr
continue:
	add dl, 0x30 
chr:	push dx ; save ascii value on stack
	inc cx ; increment count of values
	cmp ax, 0 ; is the quotient zero
	jnz nextdigit ; if no divide it again
	mov di, 0 ; point di to top left column
nextpos: 
	pop dx ; remove a digit from the stack
	mov dh, 0x07 ; use normal attribute
	mov [es:di], dx ; print char on screen
	add di, 2 ; move to next screen location
	loop nextpos ; repeat for all digits on stack
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 2
start:
	 call clrscr 
	mov ax, 0xA2B9
	push ax			 ; place number on stack
	call printnum 		; call the printnum subroutine
	mov ax, 0x4c00		 ; terminate program
int 0x21