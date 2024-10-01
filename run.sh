RUST_OBJ_FOLDER="rustcode/target/target-spec/release/deps"

# Remove files that start with "rustcode" and end with ".o"
rm -f "$RUST_OBJ_FOLDER/rustcode*.o"
rm -f "$RUST_OBJ_FOLDER/rustcode.o"

nasm src/bootloader.asm -f bin -o build/bootloader.bin
nasm src/extended.asm -f elf64 -o build/extended.o

cd rustcode
cargo rustc --release -- --emit=obj
cd ..
NEW_RUST_OBJECT=$(ls "$RUST_OBJ_FOLDER" | grep "^rustcode.*\.o$")

ld -o build/kernel.tmp -T custom-linker.ld build/extended.o "$RUST_OBJ_FOLDER/$NEW_RUST_OBJECT"


x86_64-elf-objcopy -O binary build/kernel.tmp build/kernel.bin
rm -rf build/kernel.tmp

cat build/bootloader.bin build/kernel.bin > build/kepfajl.img
