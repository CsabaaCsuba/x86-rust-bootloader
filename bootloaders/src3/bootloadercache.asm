[org 0x7c00]
[bits 16]

mov [BOOT_DISK], dl

start_16:

    mov bp, 0x7c00
    mov sp, bp

    mov bx, teststring
    call PrintString
    call Read_disk

    ;mov ah, 00h
    ;mov al, 02h
    ;int 10h

    call EnableA20
    cli
    lgdt[gdt_descriptor]
    mov cr0, eax
    or eax, 1
    mov eax, cr0
    jmp codeseg:startProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret


teststring: db "operating system starting", 0

%include "src3/interruptprint.asm"
%include "src3/gdt.asm"
%include "src3/diskreader.asm"

[bits 32]
startProtectedMode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax


    mov ebp, 0x90000
    mov esp, ebp

    ;mov [VGAStart], byte 'h'
    ;mov [VGAStart], byte 0x20 ;lehet azért nem műkszik mert nincs kiterjesztve az olvasása

    jmp $

times 510-($-$$) db 0
dw 0xaa55