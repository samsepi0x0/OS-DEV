## Notes:

Global Descriptor Table or GDT is a crucial part of 32 bit programming.
Segment based addressing allowed more memory to be accessed than just a 16 bit register could. (Physical address was 20bit, so more memory can be accessed).

In 32 bit programming, rather than Segment * 16 + Offset, Segment becomes an index to a particular segment descriptor(SD) in the GDT. 

Segment Descriptor: 8 byte structure.
    -   Base Address (32 bits / 4 bytes) : defines the beginning of the segment.
    -   Segment Limit (20 bits / 2 bytes + 4 bits) : defines the size of segment.
    -   Flags which tell cpu how to interpret the segment, like privilige level of code or read/write access.

Intel Basic Flat Model: cover 4 GB of memory. 2 segment overlapping: one data, one code.

Code and Data segment for GDT, the first entry of CPU must be an Invalid Null Pointer (8 zero bytes). Null descriptor is a mechanism to catch mistakes when we dont set a segment register before accessing an address. (some segment set to 0x0, we may forget to switch it to appropriate segment after switching to protected mode.) NULL pointer raises interrupts.


db, dw, dd are used to put specific bytes in the GDT.
CPU has no idea how long the GDT is, it gets the address of GDT Descriptor (something that describes the GDT).  6 byte structure containing:
    -   GDT SIZE (16 bits)
    -   GDT Address (32 bits)


Once GDT and descriptor are created, we need to switch from 16 bit mode to 32 bit protected mode.

#### Switching to 32 bit mode:
    -   disable interrupts using cli instruction (clear interrupts)
    -   lgdt [gdt_descriptor] to load the gdt to the memory.
    -   Set first bit of Special CPU control register cr0.
        -   mov eax, cr0        ; we copy value of cr0 to eax
        -   or eax, 0x01        ; or by 0x01 so first bit is set, rest unaffected.
        -   mov cr0, eax        ; copy back the value to cr0
    -   After cr0 is updated, CPU is in 32 bit mode*.
    -   Force CPU to finish the jobs in pipeline, so later instructions are executed in correct mode.
    -   use far jump to flush the pipeline (as CPU does not know what comes after jmp, so it clears the pipelines in this instruction or the call instruction).
    -   jmp <segment> : <address offset>
    -   jmp CODE_SEG:start_protected_mode
        -   [bits 32]
        -   start_protected_mode:
            -   ...         ; by now the cpu is running in 32 bit mode.
    -   Once in 32 bit mode, update all segments according to 32 bit mode instead of the default invalid 16 bit mode values.

