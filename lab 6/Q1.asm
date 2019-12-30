[org 0x0100]

jmp start

l:dw 8
r:dw 2

start:	mov cx,1		;initialization
	mov bp,[l]
	add bp,2
	mov dx,0		;dx will initialize to 0
	mov ax,1		;ax will store r power n
	mov si,1		;Si is acting as n
	mov di,0		;Si is acting as n

power:		
	mul word[r]			;base is multiplying with dx:ax
	dec cx
	cmp cx,0		;terminating condition for the power calculation for each term
	jne power		;repeating multiplying if the counter is not 0

	div si

	mov bx,ax		;storing sum in bx

	mov ax,1		;ax will store r power n

	inc si			;si has been prepared for calculating next power

	cmp si,bp
	je exit
	add di,bx		;Si is acting as n
	mov cx,si		;make cx counter for the next power calculation
	jmp power

exit:	

mov ax,0x4c00
int 0x21