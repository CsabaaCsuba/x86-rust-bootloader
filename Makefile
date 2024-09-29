x86_64_asm_source_files := $(shell find bootloader_new/boot/ -name *.asm)
x86_64_asm_object_files := $(patsubst bootloader_new/boot/%.asm, build/%.o, $(x86_64_asm_source_files))


$(x86_64_asm_object_files): build/%.o : bootloader_new/boot/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/%.o, bootloader_new/boot/%.asm, $@) -o $@


.PHONY: clean asm_files
asm_files: $(x86_64_asm_object_files)
	x86_64-elf-ld -n -o build/kernel.bin -T linker.ld $(x86_64_asm_object_files)

clean:
	rm build