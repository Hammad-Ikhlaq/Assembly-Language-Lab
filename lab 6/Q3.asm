[org 0x0100]

jmp start

PlainText:dd 0x15D3C257
EncryptionKey:dd 0x23CDE689

start:	

Round1:
	mov ax,0xAAAA
	xor [EncryptionKey],ax		;inverted the lower part of encryption
	xor [EncryptionKey+2],ax	;inverted the upper part of encryption


	mov bx,[EncryptionKey]
	shl word[EncryptionKey],1
	rcl word[EncryptionKey+2],1
	rcl bx,1
	mov [EncryptionKey],bx

	mov cx,[EncryptionKey+2]
	add [PlainText],bx
	adc [PlainText+2],cx

Round2:
	mov ax,0x5555
	xor [EncryptionKey],ax		;inverted the lower part of encryption
	xor [EncryptionKey+2],ax	;inverted the upper part of encryption

	mov bx,[EncryptionKey+2]
	shr word[EncryptionKey+2],1
	rcr word[EncryptionKey],1
	rcr bx,1
	mov [EncryptionKey+2],bx


	mov cx,[EncryptionKey]
	add [PlainText],cx
	adc [PlainText+2],bx

Round3:
	mov ax,0xAAAA
	xor [EncryptionKey],ax		;inverted the lower part of encryption
	xor [EncryptionKey+2],ax	;inverted the upper part of encryption

	mov bx,[EncryptionKey]
	shl word[EncryptionKey],1
	rcl word[EncryptionKey+2],1
	rcl bx,1
	mov [EncryptionKey],bx

	mov cx,[EncryptionKey+2]
	add [PlainText],bx
	adc [PlainText+2],cx

Round4:
	mov ax,0x5555
	xor [EncryptionKey],ax		;inverted the lower part of encryption
	xor [EncryptionKey+2],ax	;inverted the upper part of encryption

	mov bx,[EncryptionKey+2]
	shr word[EncryptionKey+2],1
	rcr word[EncryptionKey],1
	rcr bx,1
	mov [EncryptionKey+2],bx

	mov cx,[EncryptionKey]
	add [PlainText],cx
	adc [PlainText+2],bx

exit:	

mov ax,0x4c00
int 0x21