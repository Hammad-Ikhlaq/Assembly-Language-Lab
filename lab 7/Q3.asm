[org 0x0100]

jmp start

number:dw 0xabcd

reverse:	
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	mov bx,[bp+4]		;storing the num in bx
	mov cx,0		;storing the first index
	mov ax,0		;storing the reverse word
loop_:	
	shr word[bx],1
	rcl ax,1
	add cx,1	
	cmp cx,16
	jne loop_
	mov [bp+6],ax
	pop cx
	pop bx
	pop ax
	pop bp
	ret 2

start:	
	push 0
	mov bx,number
	push bx
	call reverse
	pop ax			;store reverse word in ax

exit:	

mov ax,0x4c00
int 0x21