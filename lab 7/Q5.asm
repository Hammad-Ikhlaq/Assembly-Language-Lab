[org 0x0100]

jmp start

arr:db 1,2,3,4,5,6,7,8,9,9,8,7,6,5,4,3,2,1

IsPalindrome:	
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push si
	mov ax,[bp+4]		;storing the ending index in ax
	mov cx,[bp+6]		;storing the first index
	mov bx,[bp+8]		;storing the array address
	cmp cx,ax		;comparing first and last
	jae true
	add bx,cx		;accessing element from start
	mov dl,[bx]		;storing first element
	mov bx,[bp+8]		;storing the array address
	add bx,ax		;accessing element from end
	cmp dl,[bx]
	jne false
	push 0
	mov bx,[bp+8]		;storing the array address
	push bx
	add cx,1		;increment first index
	push cx
	sub ax,1		;decrement last index
	push ax
	call IsPalindrome
	pop si
	mov [bp+10],si
	jmp skip
false:	mov word[bp+10],0
	jmp skip
true:	mov word[bp+10],1
skip:	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 6

start:	
	push 0		;dummy push for ans
	mov bx,arr
	push bx		;pushing array address
	mov bx,0
	push bx		;pushing starting index
	mov bx,17
	push bx		;pushing ending index
	call IsPalindrome
	pop ax			;store bool in ax

exit:	

mov ax,0x4c00
int 0x21