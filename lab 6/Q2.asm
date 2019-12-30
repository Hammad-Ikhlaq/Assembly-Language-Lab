[org 0x0100]

jmp start

size:dw 5
arr1:db 1,2,3,4,5
arr2:db 5,4,3,2,1
answer: dw 0
start:	
	mov si,0
	mov word[answer],0
traverse:
	
	mov ax, [arr1+si]
	mul byte[arr2+si]

	add byte[answer],al
	adc byte[answer+1],ah
	inc si
	cmp si,[size]	
	je exit
	jmp traverse
exit:	

mov ax,0x4c00
int 0x21