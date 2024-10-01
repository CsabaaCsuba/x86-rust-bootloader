print_to_vga: ;bx-ben az adott dolog memóriacíme, dx-ben memória offset
    mov ax, 0xb800
    mov es, ax

    mov di, dx

    mov ax, 0
    mov ds, ax
    mov cx, dx
    .loop:
        mov dl, byte [ds:bx]
        cmp dl, byte 0
        je .out
            mov [es:di], byte dl
            inc cx
            mov di, cx
            mov [es:di], byte 0x35
            inc cx
            mov di, cx
            inc bx
            jmp .loop
            
    .out:
        ret