#define UART_BASE 0x09000000
#define UART_DR   (*(volatile unsigned int *)(UART_BASE + 0x00))
#define UART_FR   (*(volatile unsigned int *)(UART_BASE + 0x18))

void uart_putc(char c) {
    while (UART_FR & (1 << 5)); // Wait until ready
    UART_DR = c;
}
void uart_init() {
    // UART initialization can be a no-op if not required
    // Some platforms require configuring the UART clock or pins
}


void uart_puts(const char *str) {
    while (*str) {
        uart_putc(*str++);
    }
}

void kernel_main() {
    uart_puts("Hello from ARM64 Kernel!\n");

    while (1) {
        // Infinite loop to keep the system running
    }
}