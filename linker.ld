ENTRY(_start)

SECTIONS
{
    . = 0x40000000;           /* Start address for code */

    .text : {
        *(.text)           /* Include all .text sections */
    }

    .data : {
        *(.data)           /* Include all .data sections */
    }

    .bss : {
        *(.bss)            /* Include all .bss sections */
        *(COMMON)          /* Include common symbols */
    }
}