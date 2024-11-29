CC = aarch64-elf-gcc
LD = aarch64-elf-ld
OBJCOPY = aarch64-elf-objcopy
CFLAGS = -mcpu=cortex-a72 -g -nostdlib -nostartfiles -ffreestanding
LDFLAGS = -T linker.ld

all: kernel.elf kernel.img

bootloader.o: bootloader.s
	$(CC) $(CFLAGS) -c bootloader.s -o bootloader.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

kernel.elf: bootloader.o kernel.o
	$(LD) $(LDFLAGS) bootloader.o kernel.o -o kernel.elf

kernel.img: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.img

clean:
	rm -f *.o *.elf *.img