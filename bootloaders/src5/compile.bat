@echo off
rem Assemble the assembly files
nasm src/bootloader.asm -f bin -o build/bootloader.bin
nasm src/extended.asm -f bin -o build/extended.bin

rem Change directory to Rust project and build
cd rustcode
cargo build
cd ..

rem Link all object files using the linker script
ld -T "custom-linker.ld" -o build/kernel.tmp build/bootloader.o build/extended.o rustcode/target/target-spec/debug/rustcode

rem Convert the linked output to a binary format
objcopy -O binary build/kernel.tmp build/kernel.bin

rem Combine the bootloader and kernel into a single image file
cd build
copy /b bootloader.bin+kernel.bin kepfajl.img
cd ..

pause
