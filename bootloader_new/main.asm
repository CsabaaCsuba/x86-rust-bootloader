[bits 16]
[org 0x7c00]

start:
    jmp main


    puts:
        push si
        push ax

    .loop:
        lodsb ;loads next character in al (increments si, then moves si into al)
        or al, al
        jz .done

        mov ah, 0x0e
        mov bh, 0
        int 0x10

        jmp .loop


.done:
    pop bx
    pop ax
    pop si
    ret


main:
    mov ax, 0
    mov ds, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x7c00

    ;print message
    mov si, msg_hello
    call puts




    hlt

.halt:
    jmp .halt



msg_hello:
    db 'bootloader working', 0

times 510-($ - $$) db 0
dw 0xaa55