#include "uart.h"
#include "framebuffer.h"

extern framebuffer_t fb;

// Draw a simple menu bar
void draw_menu_bar() {
    for (int y = 0; y < 20; y++) { // 20px high menu bar
        for (int x = 0; x < fb.width; x++) {
            fb_draw_pixel(x, y, 0x000000); // Black menu bar
        }
    }
}

// Draw a window
void draw_window(int x, int y, int width, int height, unsigned int color) {
    for (int j = y; j < y + height; j++) {
        for (int i = x; i < x + width; i++) {
            fb_draw_pixel(i, j, color);
        }
    }
}

void kernel_main() {
    uart_puts("Initializing framebuffer...\n");
    fb_init();
    fb_clear(0xC0C0C0); // Clear to gray (Classic Mac OS style)

    // Draw UI
    draw_menu_bar(); // Top menu bar
    draw_window(100, 100, 400, 300, 0xFFFFFF); // White window

    uart_puts("Framebuffer initialized. Type to see characters on the screen:\n");

    int x = 120, y = 120; // Start position for text
    while (1) {
        char c = uart_getc(); // Read a character from UART
        uart_putc(c);         // Echo it back to UART
        fb_draw_pixel(x++, y, 0x000000); // Draw a small "dot" for each character
        if (x > 500) { // Wrap text after the window width
            x = 120;
            y += 16;
        }
    }
}