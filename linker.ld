ENTRY(_start)

MEMORY
{
    ROM : ORIGIN = 0x40000000, LENGTH = 1M
    RAM : ORIGIN = 0x40001000, LENGTH = 1M
}

SECTIONS
{
    . = 0x40000000;

    .text : {
        *(.text)
    } > ROM

    .rodata : {
        *(.rodata)
    } > ROM

    .data : {
        *(.data)
    } > RAM

    .bss : {
        *(.bss)
        *(COMMON)
    } > RAM
}