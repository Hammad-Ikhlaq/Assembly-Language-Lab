
[org 0x100]
	jmp start
oldisr: dd 0 

kbisr: 
	mov ax,[oldisr]
	mov [es:16h*4],ax
	mov ax,[oldisr+2]
	mov [es:16h*4+2],ax
	mov AH, 2ah
	int 16h
	add al,32
	mov al, 0x20
	out 0x20, al
	
	iret


start:
	 xor ax, ax
	mov es, ax 

	mov ax, [es:16h*4]
	mov [oldisr], ax ; save offset of old routine
	mov ax, [es:16h*4+2]
	mov [oldisr+2], ax ; save segment of old routine	

	cli 
	mov word [es:9*4], kbisr
	mov [es:9*4+2], cs 
	sti 
l1: 
	mov ah, 0 
	int 0x16 
	jmp l1

	mov ax, 0x4c00 
	int 0x21