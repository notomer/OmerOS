.global _start
.section .text
_start:
    // Disable interrupts
    msr daifset, #0b111

    // Set up the stack
    ldr x0, =stack_top
    mov sp, x0

    // Jump to kernel_main
    bl kernel_main

    // Halt the CPU
halt:
    wfi
    b halt

.section .bss
    .align 3
stack_top:
    .space 0x1000
