[org 0x0100]

jmp start

l:dw 8
r:dw 2

power:	
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push di
	mov cx,[bp+4]			;storing n in cx
	mov bx,[bp+6]			;storing base in bx
	mov ax,1
	mov di,0

again:	mul bx				;base is multiplying with dx:ax
	add di,1
	cmp di,cx
	je skip	
	jmp again				

skip:	mov [bp+8],ax
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 4

division:
	push bp
	mov bp,sp
	push ax
	push dx
	push si
	mov si, [bp+4]			;storing divisor in si
	mov ax, [bp+6]			;storing numerator in ax
	div si
	mov [bp+8],ax
	pop si
	pop dx
	pop ax
	pop bp
	ret 4
start:	
	mov si,0		;Si is acting as n
	mov di,0		;it stores our sum
loop_:
	add si,1
	push 0			;pushing 0 to store ans
	push word[r]		;pushing base on stack
	push si			;pushing n on stack
	call power
	pop ax			;numerator is in ax
	push 0			;pushing 0 to store ans
	push ax			;pushing numerator on stack
	push si			;pushing divisor on stack
	call division
	pop ax
	add di,ax		;answer is being calculated in di
	cmp si,[l]
	jne loop_
exit:	

mov ax,0x4c00
int 0x21