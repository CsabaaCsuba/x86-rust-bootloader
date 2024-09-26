PrintString:
    mov ah, 0x0e
    .Looping:
    cmp [bx], byte 0
    je .Exit
        mov al, [bx]
        int 10h
        inc bx
        jmp .Looping
        ;loop PrintString ;ezzel az a baj hogy a 2. sori utasítást is végrehajtja
    .Exit:
    ret