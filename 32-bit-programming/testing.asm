; boot sector code that enters 32 bit protected mode.
[org 0x7c00]

  mov bp, 0x9000              ; set stack
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string

  call switch_to_pm           ; we will never return from this call.

  jmp $

%include "../boot-sector-programming/print_string.asm"
%include "./gdt.asm"
%include "./printing-routine.asm"
%include "./switching.asm"

[bits 32]
; we arrive here after moving to protected mode.

BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_string_pm        ; use 32 bit printing routine

  jmp $

MSG_REAL_MODE db "Started in 16 Bit Real Mode.", 0x0
MSG_PROT_MODE db "Successfully switched to 32-Bit Protected Mode.", 0x0

times 510-($-$$) db 0
dw 0xaa55
