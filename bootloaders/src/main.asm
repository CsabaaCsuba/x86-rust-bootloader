[org 0x7e00]

jmp EnterProtectedMode

%include "src/gdt.asm"
%include "src/basicprint.asm"

EnterProtectedMode:
    call EnableA20
    call CheckA20
    mov bx, SuccesString
    call PrintString
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp codeseg:startProtectedMode

EnableA20:
    push ax
    mov ax, 0x2401
    int 0x15
    pop ax
    ret

A20failed:
    mov bx, ErrorString
    call PrintString


CheckA20:
    push ax
    push cx
    mov ax, 0x2402 
    int 0x15
    cmp al, 00d
    pop cx
    pop ax
    je A20failed
    ret

ErrorString: 
    db "Enabling A20 failed", 0
SuccesString: 
    db "Address line 20 is now live", 13, 10, 0
ProtectedModeString:
    db "Protected mode started", 0

[bits 32]

startProtectedMode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ;mov [0xb8000], byte 'H'

    jmp $



times 2048-($-$$) db 0