;
; a boot sector program that prints using functions.
;

[org 0x7c00]


mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $ ; halt the system

%include "print_string.asm"

;    ret

; Data
HELLO_MSG:
  db 'Hello World! ', 0
GOODBYE_MSG:
  db 'Good Byte!', 0

times 510-($-$$) db 0
dw 0xaa55
