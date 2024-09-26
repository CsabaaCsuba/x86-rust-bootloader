
DetectCPUID:
    pushfd
    pop eax

    mov ecx, eax
    
    xor eax, 1 << 21
    
    push eax
    popfd

    pushfd
    pop eax

    push ecx
    popfd
    
    xor eax, ecx
    jz NoCPUID
    ret

DetectLongMode:
    
    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz NoLongMode
    ret


NoCPUID:
    mov [0xb8006], byte 'N'
    mov [0xb8007], byte 0x4
    mov [0xb8008], byte 'O'
    mov [0xb8009], byte 0x4
    jmp $

NoLongMode:
    mov [0xb800a], byte 'N'
    mov [0xb800b], byte 0x5
    mov [0xb800c], byte 'O'
    mov [0xb800d], byte 0x5
    jmp $