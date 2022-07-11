/* Based off the Bare Bones tutorial on wiki.osdev.org! */

/* Declare multiboot constants. */
.set ALIGN, 1<<0 /* Align LOADED modules on page boundaries */
.set MEMINFO, 1<<1 /* Provide memory map */
.set FLAGS, ALIGN | MEMINFO # Multiboot 'flag' field
.set MAGIC, 0x1BADB002 # Multiboot magic number
.set CHECKSUM, -(MAGIC + FLAGS) # Proves we're multiboot

/* Declare multiboot header
Proves that we're a kernel */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Create a 16kb stack
.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:


/* _start is the beginning of a system on Multiboot OSes. Everything is off. */
.section .text
.global _start
.type _start, @function
_start:
    /* Everything is off */

    # Set up the Stack
    mov $stack_top, %esp

    /*
    Set up stuff here such as paging, the FPU, and Instruction Set Extensions
    in future.
    */

    # Enter the high-level kernel
    call kernel_main

    /*
    If it somehow exited the kernel, lock the PC
    */
    cli
1:  hlt
    jmp 1b

/* Set the size of _start */
.size _start, . - _start