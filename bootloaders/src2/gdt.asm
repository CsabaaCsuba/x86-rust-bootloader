gdt_nulldesc:
    dd 0
    dd 0
gdt_codedesc:
    dw 0xFFFF       ;limit
    dw 0x0000       ;base(low)
    dw 0x00         ;base (medium)
    db 10011010b    ;Flags
    db 11001111b    ;Flags + Upper Limit
    db 0x00         ;Base(high)
gdt_datadesc:
    dw 0xFFFF
    dw 0x0000
    dw 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size:
        dw gdt_end - gdt_nulldesc - 1
        dd gdt_nulldesc


codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc


[bits 32]
EditGDT:
    mov [gdt_codedesc + 6], byte 10101111B

    mov [gdt_datadesc + 6], byte 10101111B
    ret

[bits 16]