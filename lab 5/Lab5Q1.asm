[org 0x0100]

		mov ax,0xffff
		mov bx,0xffff

	
check1:		cmp ax,0
		jz Exit
		shr ax,1
		jc carrycheck1
		jnc carrycheck2

carrycheck1:	shr bx,1
		jc check1
		jmp Exit

carrycheck2:	shr bx,1
		jnc check1
		jmp Exit
Exit:
mov ax, 0x4c00
int 21h