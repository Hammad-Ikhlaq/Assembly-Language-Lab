[org 0x0100]

JMP Start

MyArray: dw 1, 3, 10, 5, 6, 7, 1, 64, 3, 10
sum :dw 0

SumSubRoutine:

push bp
push BX			;can use pusha
push cx
push ax

mov bp, sp
mov bx, [bp+4] 		;the address of array (which was passed as parameter) will be stored in bx

mov cx, [bp+2]		;the total count (which was passed as parameter) wll be stored in cx

mov ax, 0

loop_:
    add ax, [BX]
	add BX, 2
	loop loop_
	
   mov [sum], ax	
	
	pop ax
	pop cx		;can use popa
	pop BX
	pop bp
	
	ret 4 ;the ret instruction will pop the top most value from stack and put it in the ip, so the next instruction will be executed from the address popped from stack.
	      ; here 4 means that we will add 4 in sp, this is used to clear the 2 parameters passed to this routine (each parameter is of two bytes)
	


Start:
mov bp, 1
mov BX, 2
mov cx, 3
mov ax, 10 ;the value of all these register must be preserved after the sub routine has returned

push MyArray 		;address of MyArray will be pushed
push 10 		;size of MyArray will be pushed
call SumSubRoutine


mov ax, 4c00h
int 0x21