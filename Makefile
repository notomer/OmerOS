CC = aarch64-elf-gcc
LD = aarch64-elf-ld
OBJCOPY = aarch64-elf-objcopy
CFLAGS = -mcpu=cortex-a72 -g -nostdlib -nostartfiles -ffreestanding
LDFLAGS = -T linker.ld
BUILD_DIR = build
SRC_DIR = src

all: $(BUILD_DIR)/kernel.img

# Convert ELF to raw binary for QEMU
$(BUILD_DIR)/kernel.img: $(BUILD_DIR)/kernel.elf
	$(OBJCOPY) -O binary $< $@

# Link all object files into the kernel ELF
$(BUILD_DIR)/kernel.elf: $(BUILD_DIR)/bootloader.o $(BUILD_DIR)/kernel.o $(BUILD_DIR)/uart.o $(BUILD_DIR)/framebuffer.o $(BUILD_DIR)/font.o
	$(LD) $(LDFLAGS) $^ -o $@

# Compile C source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble the bootloader
$(BUILD_DIR)/bootloader.o: $(SRC_DIR)/bootloader.s
	$(CC) $(CFLAGS) -c $< -o $@

# Compile font.c
$(BUILD_DIR)/font.o: $(SRC_DIR)/font.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)/*.o $(BUILD_DIR)/*.elf $(BUILD_DIR)/*.img