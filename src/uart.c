#include "uart.h"

void uart_putc(char c) {
    // Wait until UART is ready to transmit
    while (*(volatile unsigned int *)(UART_BASE + 0x18) & (1 << 5))
        ;
    *(volatile unsigned int *)(UART_BASE + 0x00) = c;
}

void uart_puts(const char *str) {
    while (*str) {
        uart_putc(*str++);
    }
}

char uart_getc() {
    // Wait until UART receives data
    while (*(volatile unsigned int *)(UART_BASE + 0x18) & (1 << 4))
        ;
    return *(volatile unsigned int *)(UART_BASE + 0x00);
}