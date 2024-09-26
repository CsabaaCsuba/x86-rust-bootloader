[org 0x7c00]
[bits 16]

mov [BOOT_DRIVE], dl

mov bp, 0x7c00
mov sp, bp 



mov bx, anyad
call print_string

;big screen for big dicks
;mov ah, 00h
;mov al, 0001_0010b   ;12h == 18D
;int 10h

; ~~~ for some reason it kills the ability to read???

call disk_read

jmp PROGRAM_SPACE

jmp $

anyad:
    db 'joez a cucc', 0

%include "src/print.asm"
%include "src/diskreader.asm"

times 510-($-$$) db 0
dw 0xaa55