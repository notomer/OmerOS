#ifndef UART_H
#define UART_H


#define UART_BASE 0x09000000

void uart_putc(char c);
void uart_puts(const char *str);
char uart_getc();

#endif