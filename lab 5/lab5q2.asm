[org 0x0100]


		mov ax,0xffff
		mov bx,ax
	
check1:		cmp ax,0
		jz Exit
		shr ax,1
		jc leftcheck1
		jnc leftcheck2

leftcheck1:	shl bx,1
		jc check1
		jmp Exit

leftcheck2:	shl bx,1
		jnc check1
		jmp Exit

Exit:
	mov ax,0x4c00
	int 21h