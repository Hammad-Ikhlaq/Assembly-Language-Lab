[org 0x0100]


		mov ax,0xf
		mov bx,0
		mov bx,1
		mov cx,ax

looping:	shl bx,1
		sub cx,1
		cmp cx,0	
		jnz looping
		shr bx,1
		xor ax,bx
Exit:
	mov ax,0x4c00
	int 21h