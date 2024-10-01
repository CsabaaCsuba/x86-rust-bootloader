jmp continue
%include "src/gdt.asm"

continue:
    mov ax, 0xb800
    mov es, ax
    xor bx, bx
    mov [es:bx], byte 'O' ;b8000
    inc bx
    mov [es:bx], byte 0x03 ;b8001
    inc bx
    mov [es:bx], byte 'K' ;b8002
    inc bx
    mov [es:bx], byte 0x03 ;b8003

    call EnableA20
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:Start32



EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "src/CPUID.asm"
%include "src/paging.asm"

Start32:
    mov ax, DATA_SEG ; Now in PM , our old segments are meaningless ,
    mov ds, ax ; so we point our segment registers to the
    mov ss, ax ; data selector we defined in our GDT
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp




    call DetectCPUID
    call DetectLongMode
    call SetupIdentityPaging
    call EditGDT

    jmp Start64


[bits 64]
[extern _start]

Start64:
    call BlueScreen

    xor rcx, rcx
    mov cx, 80d
    
    call set_cursor


    mov rbx, akarmi
    call print_anything

    mov cx, 160d
    call set_cursor

    xor rbx, rbx
    mov rbx, 0xf
    call convert_hex_to_string


    
    
    mov rbx, converted_str
    call print_anything
    ;jmp $

    call _start


    jmp $


BlueScreen:
    mov rdi, 0xb8000
    mov rcx, 0
    mov rax, 1
    .doit:
        cmp rcx, 2000 ;2000 karakteres a screen
        je .itsblued
            mov [rdi], byte ' ' ;space karakter
            add rdi, 1
            mov [rdi], byte 0x14 ;első a betűszín, második a háttérszín
            add rdi, 1
            add rcx, 1
            mov rax, 0
            jmp .doit


    .itsblued:
        ret

akarmi:
    db "64-bit long mode enabled", 0



%include "src/cursorset.asm"
%include "src/printfunction.asm"
%include "src/convertvalues.asm"
times 2048-($-$$) db 0