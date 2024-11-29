.global _start        // Define the global entry point

.section .text        // Code section
_start:
    // Disable interrupts
    msr daifset, #0b111      // Disable Debug, Async, IRQ, and FIQ interrupts

    // Set up the stack
    ldr x0, =stack_top        // Load the address of the stack top
    mov sp, x0                // Set the stack pointer

    // Call kernel_main (defined in kernel.c)
    bl kernel_main

    // Infinite loop to halt the system
halt:
    wfi                       // Wait for interrupt (low power mode)
    b halt                    // Loop forever

.section .bss                 // Uninitialized data section
    .align 3                  // Ensure proper memory alignment (8-byte alignment for ARM64)
stack_top:
    .space 0x1000             // Reserve 4 KB for the stack