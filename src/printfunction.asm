print_anything:
    push cx

    mov ax, 2d
    push cx
    push ax
    pop cx
    pop ax
    
    mul cx ;ax cx-szel lesz beszorozva, dx:ax-ben az eredmény

    mov cx, ax
    mov rax, [vga_memory_start]
    add ax, cx

    pop cx

    .loop:
        mov dl, byte [rbx]
        cmp dl, 0
        je .end
            mov [rax], byte dl
            inc ax
            mov [rax], byte 0x69
            inc ax
            inc bx
            inc cx
            jmp .loop
    .end:
        dec cx
        call set_cursor

        ret

vga_memory_start: dd 0xb8000