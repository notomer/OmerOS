#include "framebuffer.h"
#include "font.h"

framebuffer_t fb;

void fb_draw_char(int x, int y, char c, unsigned int color) {
    for (int i = 0; i < 8; i++) { // Each character is 8 pixels tall
        unsigned char row = font[(int)c][i];
        for (int j = 0; j < 8; j++) { // Each row is 8 pixels wide
            if (row & (1 << (7 - j))) {
                fb_draw_pixel(x + j, y + i, color);
            }
        }
    }
}

void fb_init() {
    fb.width = 800;
    fb.height = 600;
    fb.pitch = fb.width * 4;  // 4 bytes per pixel (RGBA)
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