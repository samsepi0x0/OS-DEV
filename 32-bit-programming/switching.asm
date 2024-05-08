[bits 16]
; switching to protected mode.

switch_to_pm:
  cli               ; stop interrupts until we have setup 32 bit mode, otherwise interrupts
                    ; will crash
  lgdt [gdt_descriptor]   ; load the gdt which defines protected mode segments.

  mov eax, cr0      ; copy value of control register to eax
  or eax, 0x01      ; set the first bit
  mov cr0, eax      ; copy back te value to control register.

  jmp CODE_SEG:init_pm    ; mark a far jump to clear the pipeline


[bits 32]
; Initilize registers and stack in PM

init_pm:
  mov ax, DATA_SEG        ; point to new segments defined in GDT.
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000        ; update stack position so it is right at top of free space.
  mov esp, ebp

  call BEGIN_PM           ; call well known labels.

