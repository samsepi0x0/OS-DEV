;
; a simple boot sector program that loops forever.
;

loop:
  jmp loop            ; use a simple cpu instruction that jumps to
                      ; a new memory addres,s in this case, jums to current
                      ; instruction.

times 510-($-$$) db 0 ; when compiled, the program must fit into 512 bytes
                      ; with the last two bytes being 0xaa55. So here tell
                      ; assembler to pad our program with zero bytes(db 0)
                      ; to bring us to 510th byte.

dw 0xaa55             ; last two bytes are magic number, helps bios know
                      ; it is a boot sector.
