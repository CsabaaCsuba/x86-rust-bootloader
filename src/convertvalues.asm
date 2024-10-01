;convert hex values to ascii

convert_hex_to_string: ;it will give the pointer of the string ;the maximum length of a number is 0xFFFFFFFFFFFFFFFF
    ;rbx-ben lesznek a számok
    push rcx
    xor rcx, rcx
    
    

    push rbx
    .shiftloop:
        cmp ebx, 0 ;akkor száll ki, ha találkozik 0 értékkel
        je .end
            mov rdx, rbx
            shr rbx, 4
            cmp bl, 0x09
            jnge .normalnum
            jg .hexnum

    .normalnum:
        mov rbx, rdx
        xor rdx, rdx
        shr rbx, 4
        mov dl, bl
        add dl, 48d
        mov [rcx+converted_str], byte dl
        inc cx
        jmp .shiftloop

    .hexnum:
        mov rbx, rdx
        xor rdx, rdx
        shr rbx, 4
        mov dl, bl
        add dl, 86d
        mov [rcx+converted_str], byte dl
        inc cx
        jmp .shiftloop

    .end:
        pop rbx
        pop rcx
        ret


converted_str: times 33 db 0