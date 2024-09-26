ENTRY(_start)
INPUT
(
    build\extended.o
    rustcode\target\target-spec\debug\deps\rustcode-90a1941c70347801.o
)

OUTPUT
(
    build\kernel.tmp
)

SECTIONS
{
    . = 0x8000;
    
    .text : ALIGN(0x1000)
    {
        *(.text)
    }

    .data : ALIGN(0x1000)
    {
        *(.data)
    }

    .rodata : ALIGN(0x1000)
    {
        *(.rodata)
    }

    .bss : ALIGN(0x1000)
    {
        *(COMMON)
        *(.bss)
    }
}