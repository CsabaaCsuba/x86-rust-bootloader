[org 0x7E00]


jmp EnterProtectedMode

WHITE_ON_BLACK equ 0x0f
VIDEO_MEMORY equ 0xb8000
VGAStart equ 0xB8000

%include "src2/gdt.asm"
%include "src/basicprint.asm"


EnterProtectedMode:
    call EnableA20
    cli ;don't interrupt before using cli, else it'll crash
    lgdt [gdt_descriptor]
    ;mov eax, cr0
    ;or eax, 1
    ;mov cr0, eax
    mov cr0, eax
    or eax, 1
    mov eax, cr0
    jmp codeseg:startProtectedMode


;EnableA20:
;    push ax
;    mov ax, 0x2401
;    int 0x15
;    pop ax
;    ret

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]
%include "src2/cpuid.asm"
%include "src2/paging.asm"


startProtectedMode:

    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax


    mov ebp, 0x90000
    mov esp, ebp
    

    call DetectCPUID
    call DetectLongMode
    call SetupIdentityPaging
    call EditGDT
    jmp codeseg:Start64Bit


[bits 64]

Start64Bit:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20

    mov ecx, 500
    rep stosq
    jmp $

times 2048-($-$$) db 0