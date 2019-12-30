[org 0x0100]

mov ax, 2
mov bx, 1
add ax,bx ;ax=3,bx=1,cx=0
mov cx,ax ;ax=3
add ax,bx ;ax=4
mov bx,ax ;ax=4
add ax,cx ;ax=7
mov cx,ax ;ax=7
add ax,bx ;ax=11
mov bx,ax ;ax=11
add ax,cx ;ax=18
mov cx,ax ;ax=18
add ax,bx ;ax=29
mov bx,ax ;ax=29
add ax,cx ;ax=47
mov cx,ax ;ax=47
add ax,bx ;ax=76

mov ax, 0x4c00
int 0x21