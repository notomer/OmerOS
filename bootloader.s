.global _start
.section .text

_start:
    // Disable interrupts
    msr daifset, #0b111

    // Switch to EL1 (if not already in EL1)
    mrs x0, CurrentEL
    cmp x0, #0b0100      // Check if already in EL1
    b.eq 1f
    mov x0, #0x3C5       // Set HCR_EL2 for EL1 execution
    msr HCR_EL2, x0
    mov x0, #0x3C0
    msr SCTLR_EL1, x0
    eret                 // Return to EL1

1:  // Set up stack
    ldr x0, =stack_top
    mov sp, x0

    // Call kernel
    bl kernel_main

    // Infinite loop
halt:
    wfi
    b halt