[org 0x0100]
	
	mov bx,0
	mov si,-1
        mov di,-1

upperloop:
		add si,1
		cmp si,9
		je Exit
		mov di,0
lowerloop:

		add di,1
		cmp di,9
		je upperloop

		mov ah,[array1+si]
		mov al,[array2+di]

		cmp ah,al
		je assignment
		jmp lowerloop
		
assignment:	mov [array3+bx],ah
		mov [array1+si],0
		add bx,1
		jmp lowerloop



Exit:	mov ax,0x4c00
	int 21h

array1: db 3,5,9,10,99,4,1,3,150,8
array2: db 1,2,3,4,5,6,7,8,9,10
array3: db 0,0,0,0,0,0,0,0,0,0