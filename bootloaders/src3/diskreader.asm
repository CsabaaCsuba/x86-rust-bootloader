PROGRAM_SPACE equ 0x7e00

Read_disk:
    mov ah, 0x02
    mov bx, PROGRAM_SPACE
    mov al, 4 ;szektorok
    mov dl, [BOOT_DISK]
    mov ch, 0x00 ;cylinder = 0
    mov dh, 0x01 ;head = 0
    mov cl, 0x02 ;sector 2???

    int 0x13
    
    jc DiskReadFailed

    ret

BOOT_DISK:
    db 0

DiskReadError:
    db "Disk Read Failed", 0

DiskReadFailed:
    mov bx, DiskReadError
    call PrintString
    jmp $