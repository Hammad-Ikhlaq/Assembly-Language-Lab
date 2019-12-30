[org 0x0100]

mov ax, 34
mov bx, 21
sub ax,bx ;ax=13,bx=21,cx=0
mov cx,ax ;ax=13,bx=21,cx=13
sub bx,ax ;ax=13,bx=8,cx=13
mov cx,bx ;ax=13,bx=8,cx=8
sub ax,bx ;ax=5,bx=8,cx=8
mov cx,ax ;ax=5,bx=8,cx=5
sub bx,ax ;ax=5,bx=3,cx=5
sub ax,bx ;ax=2,bx=3,cx=5
mov cx,bx ;ax=2,bx=3,cx=3
sub bx,ax ;ax=2,bx=1,cx=3
sub ax,bx ;ax=1,bx=1,cx=3
sub ax,bx ;ax=0,bx=1,cx=3

mov ax, 0x4c00
int 0x21