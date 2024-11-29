#ifndef FRAMEBUFFER_H
#define FRAMEBUFFER_H

#define FRAMEBUFFER_BASE 0x08000000

typedef struct {
    unsigned int width;
    unsigned int height;
    unsigned int pitch;
    unsigned char *buffer;
} framebuffer_t;

void fb_init();
void fb_draw_pixel(int x, int y, unsigned int color);
void fb_clear(unsigned int color);

#endif