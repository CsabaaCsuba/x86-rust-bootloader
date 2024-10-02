
PROGRAM_SPACE equ 0x8000

disk_read:
    mov ah, 0x02
    mov bx, PROGRAM_SPACE
    mov al, 64 ;hány szektort
    mov dl, [BOOT_DRIVE] ;meghajtó száma??
    mov ch, 0x00 ;hányadik lemezről
    mov dh, 0x00 ;head
    mov cl, 0x02 ;hányadik szektor

    int 0x13

    jc on_fail

    ret

BOOT_DRIVE:
    db 0x00

on_fail:
    mov bx, failstr
    call print_string
    jmp $

failstr:
    db 'read from disk failed', 0