[org 0x7e00]
[bits 16]


mov bx, ExtendedString
call print_string

cli
call EnableA20
lgdt [gdt_descriptor]
mov eax, cr0
or eax, 0x01
mov cr0, eax
jmp CODE_SEG:Start_32_bit


EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

%include "src4/print.asm"
%include "src4/gdt.asm"

[bits 32]
Start_32_bit:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb800000], byte 'W'
    mov [0xb800001], byte 0x02
    mov [0xb800003], byte 'o'
    mov [0xb800004], byte 0x02
    mov [0xb800005], byte 'W'
    mov [0xb800006], byte 0x02

    jmp $


ExtendedString:
    db "Damn bro an other drive", 0

times 2048-($-$$) db 0