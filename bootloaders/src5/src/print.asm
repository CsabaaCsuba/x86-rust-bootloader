print_string:
    mov ah, 0eh
    .loop:
    cmp [bx], byte 0
    je .out
        mov al, [bx]
        int 10h
        inc bx
        jmp .loop

    .out:
        ret
