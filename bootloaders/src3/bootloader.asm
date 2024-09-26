[org 0x7c00]
[bits 16]

mov [BOOT_DISK], dl

jmp start_16
start_16:

    mov bx, teststring
    call PrintString

    call Read_disk


%include "src3/interruptprint.asm"
%include "src3/diskreader.asm"

teststring:
    db "teststring", 0


times 510-($-$$) db 0
dw 0xaa55