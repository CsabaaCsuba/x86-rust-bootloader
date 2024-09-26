[org 0x7c00]
[bits 16]

mov [BOOT_DISK], dl

mov bp, 0xc700
mov sp, bp



;mov bx, str
;call print_string


call Read_disk

jmp PROGRAM_SPACE

%include "src4/print.asm"
%include "src4/diskreader.asm"
str:
    db "nem akarok letezni", 0

times 510-($-$$) db 0
dw 0xaa55