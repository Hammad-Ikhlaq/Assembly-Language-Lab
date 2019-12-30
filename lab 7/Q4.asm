[org 0x0100]

jmp start

arr:dw 23,26,29,32,52,61,78,99,178,237
key:dw 61
binarySearch:	
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	mov ax,[bp+6]		;moving r in ax
	cmp ax,[bp+8]		;comparing r and l
	jb assignl		;skip the if condition if r is less than l
	sub ax,[bp+8]		;r-l
	mov bx,2
	div bx			;divided r-l by 2
	mov dx,0		;clearing dx
	add ax,[bp+8]		;calculating mid
	mov bx,[bp+10]		;storing array address in bx
	mov si,ax		;storing mid in si
	shl si,1
	mov di,	[bp+4]	;loading key in di
	cmp [bx+si],di	;comparing middle element of array with key
	je assignmid
	ja recursion1
	jmp recursion2
recursion1:
	push 0
	push bx			;pushing the address of array
	mov ax,[bp+8]		; loading l in ax	
	push ax
	shr si,1
	sub si,1
	push si
	push di			;pushing key in di
	call binarySearch
	pop ax
	jmp assignmid
recursion2:
	push 0
	push bx			;pushing the address of array
	shr si,1
	add si,1
	push si
	mov ax,[bp+6]		; loading r in ax
	push ax
	push di			;pushing key in di
	call binarySearch
	pop ax
	jmp assignmid
assignmid:	mov [bp+12],ax
		jmp exit
assignl: mov word[bp+12],-1
exit:	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 8

start:	
	push 0
	mov bx,arr
	push bx		;pushing array
	mov bx,0	
	push bx		;pushing l
	mov bx,9
	push bx		;pushing r
	mov bx,[key]
	push bx		;pushing key
	call binarySearch
	pop ax			;store reverse word in a	

mov ax,0x4c00
int 0x21