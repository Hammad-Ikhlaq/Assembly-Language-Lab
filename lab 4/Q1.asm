[org 0x0100]

	mov bx,[num1]
	mov cx,[num2]
	mov dx,[num3]

shortcircuit:

	cmp bx,dx
	jae shortcircuit2
	jmp SecCondition1

shortcircuit2:

	cmp bx,cx
	jae assignment1
	jmp SecCondition1

assignment1:

	mov ax,bx
	jmp Exit

SecCondition1:

	cmp cx,bx
	jae SecCondition1	
	jmp last	

SecCondition2:

	cmp cx,dx
	jae assignment2
	jmp last

assignment2:

	mov ax,cx
	jmp Exit
last:
	mov ax,dx

Exit:	mov ax,0x4c00
	int 21h

num1: dw 10
num2: dw 5
num3: dw 2