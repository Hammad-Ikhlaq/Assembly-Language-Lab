[org 0x100]

mov ax, [n1]
mov bx, n2
add ax, [bx]
mov ax, 5
mov ax, [bx]

add [n1], ax

mov byte[n1],20
mov cx, [n3]

mov ax, 0x4c00 		; terminate program
int 0x21

n1 :db  5

n2: db  10
n3: dw  20
