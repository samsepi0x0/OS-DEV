## Understanding kernel and C compiler

### GNU Compiler Collection:
Useful flags:
    -   -ffreestanding: Asserts that the compilation is for freestanding environment. Standard libraries might not exist and the program startup may not be at host.
    -   Code in object file uses relative addressing rather than absolute addressing.
    -   Linker links together all the routines in the object file and generates an executable binary with absolute addressing instead of relative addressing within the compiled machine code.
    -   -Ttext 0x0: similar to org instruction in x86, tells compiler to offset label address across the code, to absolute memory addresses.
    -   ndisasm -b 32 basic.bin > basic.dis : disassemble the linker generated binary file.


CPU instructions:
    -   store the base address of the previous stack frame so that it can be used later on when returning from the calling function.
    -   mov ebp, esp: create a new stack frame on top of existing one by defining it at the top(esp) of the current stack frame.
    -   After function's work is done, pop ebp to restore the base pointer of the original stack frame and return from the function to (IP + 1)th instruction.
