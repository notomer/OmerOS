#define UART_BASE 0x09000000
#define UART_DR   (*(volatile unsigned int *)(UART_BASE + 0x00))
#define UART_FR   (*(volatile unsigned int *)(UART_BASE + 0x18))
#define FRAMEBUFFER_BASE 0x08000000  // QEMU RAM framebuffer base

typedef struct {
    unsigned int width;
    unsigned int height;
    unsigned int pitch;
    unsigned int is_rgb;
    unsigned char *buffer;
} framebuffer_t;

framebuffer_t fb;

void fb_init() {
    fb.width = 800;    // Set resolution
    fb.height = 600;
    fb.pitch = fb.width * 4;  // 4 bytes per pixel (RGBA)
    fb.is_rgb = 1;     // True color
    fb.buffer = (unsigned char *)FRAMEBUFFER_BASE;
}

void fb_draw_pixel(int x, int y, unsigned int color) {
    unsigned int *pixel = (unsigned int *)(fb.buffer + y * fb.pitch + x * 4);
    *pixel = color;
}

void fb_clear(unsigned int color) {
    for (int y = 0; y < fb.height; y++) {
        for (int x = 0; x < fb.width; x++) {
            fb_draw_pixel(x, y, color);
        }
    }
}

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