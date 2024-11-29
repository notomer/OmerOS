ENTRY(_start)          /* Entry point: _start in bootloader.S */

SECTIONS
{
    . = 0x80000;

    .text : ALIGN(4) {
        *(.text)
    }

    .data : ALIGN(4) {
        *(.data)
    }

    .bss : ALIGN(4) {
        *(.bss)
        *(COMMON)
    }
}