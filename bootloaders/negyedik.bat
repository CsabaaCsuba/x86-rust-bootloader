cd C:\Users\Csabi\Desktop\primitiveOsByMe
nasm src4/bootloader.asm -f bin -o build/bootloader.bin
nasm src4/extended.asm -f bin -o build/extended.bin
cd C:\Users\Csabi\Desktop\primitiveOsByMe\build
copy /b bootloader.bin+extended.bin bochs_tester3.img
pause