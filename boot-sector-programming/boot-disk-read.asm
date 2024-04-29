[org 0x7c00]

mov [BOOT_DRIVE], dl      ; bios stores boot drive in DL, make a copy of it.
mov bp, 0x8000            ; safe way to get out of stack, so copy
mov sp, bp

mov bx, 0x9000            ; load 5 sectors to 0x0000:0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load
mov dx, [0x9000]          ; Print the first loaded word "Expected 0xdada"
call print_hex

mov dx, [0x9000 + 512]    ; print first word of second loaded sector "Expected 0xface"
call print_hex

jmp $

%include "print_string.asm"
%include "boot-disk-load.asm"

BOOT_DRIVE:
  db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdead
times 256 dw 0xface
