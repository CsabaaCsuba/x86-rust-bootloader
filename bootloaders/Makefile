ASM=nasm

SRC_DIR=src
BUILD_DIR=build
x86_64_asm_source_files := $(shell find src -name *.asm)
x86_64_asm_object_files := $(patsubst src/%.asm, build/%.bin, $(x86_64_asm_source_files))

#a cleanekkel ésszel
#.PHONY: cleanvirtualimg


#$(BUILD_DIR)/main.vdi: $(BUILD_DIR)/main_floppy.img
#	VBoxManage convertdd $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/main.vdi

#$(BUILD_DIR)/main.vdi: $(BUILD_DIR)/main_floppy.img
#	VBoxManage convertdd $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/main.vdi

#$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin $(BUILD_DIR)/bootloader.bin
#	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
#	cp $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/main.bin
	truncate -s 1440k $(BUILD_DIR)/main_floppy.img
    
#$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/other.bin
#	cp $(BUILD_DIR)/other.bin $(BUILD_DIR)/other_floppy.img
#	truncate -s 1440k $(BUILD_DIR)/main_floppy.img
 
#$(BUILD_DIR)/bootloader.bin: $(SRC_DIR)/bootloader.asm $(SRC_DIR)/main.asm
#	$(ASM) $(SRC_DIR)/bootloader.asm -f bin -o $(BUILD_DIR)/bootloader.bin
#$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
#	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin

#$(x86_64_asm_object_files): build/%.bin : src/%.asm
#	nasm -f elf64 $(patsubst build/%.bin, src/%.asm, $@) -o $@

#$(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/main.bin: $(SRC_DIR)/bootloader.asm $(SRC_DIR)/main.asm
	
#	$(ASM) $(SRC_DIR)/bootloader.asm -f bin -o $@
#	$(ASM) $(SRC_DIR)/main.asm -f bin -o $@ 

#cleanvirtualimg:
#	rm -f $(BUILD_DIR)/*.vdi
