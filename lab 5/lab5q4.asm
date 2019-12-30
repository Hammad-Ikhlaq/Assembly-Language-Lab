[org 0x0100]


		mov ax,0xc5a3
		mov bx,-1

looping1:	cmp ax,0
		je check
		add bx,1
		shr ax,1
		jc looping1
		jmp looping2

looping2:	cmp ax,0
		je check
		shr ax,1
		jc looping1
		cmp ax,0
		jne looping2
		
check:		
		mov ax,bx
		cmp bx,1
		je Exit
		jmp looping2
Exit:
	mov ax, bx
	mov ax,0x4c00
	int 21h