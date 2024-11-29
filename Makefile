# Cross-compiler toolchain
CC = aarch64-elf-gcc
LD = aarch64-elf-ld
OBJCOPY = aarch64-elf-objcopy
QEMU = qemu-system-aarch64

# Compiler and linker flags
CFLAGS = -mcpu=cortex-a72 -g -nostdlib -nostartfiles -ffreestanding
LDFLAGS = -T linker.ld

# Target binary
TARGET = kernel.img

# Object files
OBJS = bootloader.o kernel.o

# Default target
all: $(TARGET)

# Compile bootloader
bootloader.o: bootloader.S
	$(CC) $(CFLAGS) -c bootloader.S -o bootloader.o

# Compile kernel
kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

# Link kernel and bootloader
kernel.elf: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o kernel.elf

# Convert ELF to binary image
kernel.img: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.img

# Clean build artifacts
clean:
	rm -f $(OBJS) kernel.elf kernel.img

# Run the OS in QEMU
run: $(TARGET)
	$(QEMU) -M virt -cpu cortex-a72 -nographic -kernel $(TARGET)