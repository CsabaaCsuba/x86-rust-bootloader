cd C:\Users\Csabi\Desktop\primitiveOsByMe
nasm src3/bootloader.asm -f bin -o build/bootloader.bin
nasm src3/main.asm -f bin -o build/main.bin
cd C:\Users\Csabi\Desktop\primitiveOsByMe\build
copy /b bootloader.bin+main.bin bochs_tester2.img
pause