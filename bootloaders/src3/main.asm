[org 0x7e00]
[bits 16]

jmp continue

%include "src3/gdt.asm"
%include "src3/cpuid.asm"
%include "src3/paging.asm"
%include "src3/interruptprint.asm"

otherstr: 
    db "I hate my life", 0

VGA16 equ 0xb800
VGA32 equ 0xb8000

continue:
    mov ax, 0xb800
    mov ds, ax ;This is the segment register that should hopefully give me 0xb8000
    ;mov word [ds:0x0000], 'H'
    ;mov word [ds:0x0001], 0x0f
    mov bx, otherstr
    call PrintString

    call EnableA20
    cli
    xor ax, ax
    mov ds, ax
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:startProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

startProtectedMode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ;mov [ds:0x0000], byte 'H'
    ;mov [ds:0x0001], byte 0x0f
    ;mov [VGA32], byte 'H'
    ;mov [VGA32+1], byte 0x0f

    jmp $

    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPaging
    call EditGDT

    jmp CODE_SEG:Start64


[bits 64]
Start64:
    
    ;mov edi, 0xb8000
    ;mov rax, 0x1f201f201f201f20
    ;mov ecx, 500
    ;rep stosq

    jmp $






times 2048-($-$$) db 0