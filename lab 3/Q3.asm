[org 0x0100]

mov ax,[Array1]
add ax,[Array2]
mov [Array3],ax

mov ax,[Array1+2]
add ax,[Array2+2]
mov [Array3+2],ax

mov ax,[Array1+4]
add ax,[Array2+4]
mov [Array3+4],ax

mov ax,[Array1+6]
add ax,[Array2+6]
mov [Array3+6],ax

mov ax,[Array1+8]
add ax,[Array2+8]
mov [Array3+8],ax

mov ax,[Array1+10]
add ax,[Array2+10]
mov [Array3+10],ax

mov ax,[Array1+12]
add ax,[Array2+12]
mov [Array3+12],ax

mov ax,[Array1+14]
add ax,[Array2+14]
mov [Array3+14],ax

mov ax,[Array1+16]
add ax,[Array2+16]
mov [Array3+16],ax

mov ax,[Array1+18]
add ax,[Array2+18]
mov [Array3+18],ax
mov ax,0x4c00
int 0x21

Array1: dw 101, 200, 500,320,550, 632, 400, 100, 200 , 900		
Array2: dw 50, 99, 256, 230, 550, 600, 220, 100 , 200 , 300 		
Array3:	dw 0,0,0,0,0,0,0,0,0,0
