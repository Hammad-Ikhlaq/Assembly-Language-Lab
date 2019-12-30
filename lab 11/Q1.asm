[org 0x0100]
jmp start
oldisr: dd 0 
flag: db 0
prn:	mov byte [es:0], 'l' 
	mov byte [es:2], 'e'
	mov byte [es:4], 'f'
	mov byte [es:6], 't'
	mov byte [es:8], ' '
	mov byte [es:10], 's'
	mov byte [es:12], 'h'
	mov byte [es:14], 'i'
	mov byte [es:16], 'f'
	mov byte [es:18], 't'
	mov byte [es:20], '+'
	mov byte [es:22], 'A'
	mov byte [es:24], ' '
	mov byte [es:26], 'p'
	mov byte [es:28], 'r'
	mov byte [es:30], 'e'
	mov byte [es:32], 's'
	mov byte [es:34], 's'
	mov byte [es:36], 'e'
	mov byte [es:38], 'd'
	jmp exit

clr1:	mov byte [es:0], ' ' 
	mov byte [es:2], ' '
	mov byte [es:4], ' '
	mov byte [es:6], ' '
	mov byte [es:8], ' '
	mov byte [es:10], ' '
	mov byte [es:12], ' '
	mov byte [es:14], ' '
	mov byte [es:16], ' '
	mov byte [es:18], ' '
	mov byte [es:20], ' '
	mov byte [es:22], ' '
	mov byte [es:24], ' '
	mov byte [es:26], ' '
	mov byte [es:28], ' '
	mov byte [es:30], ' '
	mov byte [es:32], ' '
	mov byte [es:34], ' '
	mov byte [es:36], ' '
	mov byte [es:38], ' '
	jmp nextcmp3

clr2:	mov byte [es:0], ' ' 
	mov byte [es:2], ' '
	mov byte [es:4], ' '
	mov byte [es:6], ' '
	mov byte [es:8], ' '
	mov byte [es:10], ' '
	mov byte [es:12], ' '
	mov byte [es:14], ' '
	mov byte [es:16], ' '
	mov byte [es:18], ' '
	mov byte [es:20], ' '
	mov byte [es:22], ' '
	mov byte [es:24], ' '
	mov byte [es:26], ' '
	mov byte [es:28], ' '
	mov byte [es:30], ' '
	mov byte [es:32], ' '
	mov byte [es:34], ' '
	mov byte [es:36], ' '
	mov byte [es:38], ' '
	jmp exit
kbisr: 
	push ax
	push es
	mov ax, 0xb800
	mov es, ax ; point es to video memory

	in al, 0x60 ; read a char from keyboard port

	cmp al, 0x2a
	jne nextcmp
	mov byte[flag],1
	jmp exit
nextcmp:
	CMP byte[flag],1
	jne nextcmp2
	cmp al, 0x1e
	je prn
	jmp exit

nextcmp2: 
	cmp al, 0xaa
	jne clr1
	jne nextcmp3
	jmp exit

nextcmp3: 
	mov byte[flag],0
	cmp al, 0x9e
	jne clr2
	jne nomatch
	jmp exit
nomatch:
	pop es
	pop ax
	jmp far [cs:oldisr] 
exit:
	mov al, 0x20
	out 0x20, al 
	pop es
	pop ax
	iret 
start: 
	xor ax, ax
	mov es, ax
	mov ax, [es:9*4]
	mov [oldisr], ax 
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax 
	cli 
	mov word [es:9*4], kbisr 
	mov [es:9*4+2], cs 
	sti 
	mov dx, start
	add dx, 15 
	mov cl, 4
	shr dx, cl 
	mov ax, 0x3100 
	int 0x21