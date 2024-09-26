[org 0x7C00]
[bits 16]

mov [BOOT_DISK], dl

mov bp, 0x7D80
mov sp, bp

mov bx, Message
call PrintString

call ReadDisk

Message:
    db "hello", 0

jmp PROGRAM_SPACE

%include "src/basicprint.asm"
%include "src/diskreader.asm"



times 510-($-$$) db 0
dw 0xAA55