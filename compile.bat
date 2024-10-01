cd C:\Users\Csabi\Desktop\primitiveOsByMe\src5
nasm src/bootloader.asm -f bin -o build/bootloader.bin
nasm src/extended.asm -f elf64 -o build/extended.o

cd rustcode
cargo rustc --target target-spec.json --  --emit=obj
cd C:\Users\Csabi\Desktop\primitiveOsByMe\src5

ld -T "custom-linker.ld"

objcopy -O binary build\kernel.tmp build\kernel.bin

cd build
copy /b bootloader.bin+kernel.bin kepfajl.img
cd ..
pause