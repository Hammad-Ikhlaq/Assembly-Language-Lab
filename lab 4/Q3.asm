[org 0x0100]

	mov bx,0
	mov ch,1
	mov dh,[key]

Replace: 
	mov  ah, [array+bx]       ; AX has max


L1: 
            cmp ch , 10           ; Loop terminating condition  
            je keyCheck1
            
            add bx ,1             ;  +1 in index because of byte type array
            add ch,1              ; counter to maintain size

            cmp [array+bx],ah     
            ja  Replace          

            JMP L1            


keyCheck1:	
		
            mov bx,0
	    mov ch,1
	    JMP keyCheck2
Replace2:
	
	    mov [array+bx],ah 

keyCheck2:	  
         
	    cmp ch , 10           ; Loop terminating condition  
            je Exit

            add bx ,1             ;  +1 in index because of byte type array
            add ch,1              ; counter to maintain size

            cmp [array+bx],dh    
            je  Replace2           

            JMP keyCheck2


Exit:	mov ax,0x4c00
	int 21h

array: db 3,5,9,10,99,4,1,3,150,8
key: db 1