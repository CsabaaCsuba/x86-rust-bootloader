set_cursor:
    push cx

    mov dx, [port1]
    mov al, [setting1]
    out dx, al


    mov dx, [port2]
    and cl, 0xFF
    mov al, cl
    out dx, al


    mov dx, [port1]
    mov al, [setting2]
    out dx, al


    mov dx, [port2]
    shr cx, 8 ;position = position >> 8
    and cl, 0xFF
    mov ax, cx
    out dx, al

    pop cx

    ret
    




port1: dw 0x3D4
setting1: db 0x0F

port2: dw 0x3D5
setting2: db 0x0E


;%include "src/io.asm"