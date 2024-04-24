;
; Simple boot sector program that demonstrates the stack
;

mov ah, 0x0e

mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x8000]  ;should print gibberish now that the value has been popped from the stack
int 0x10

jmp $ ; jmp forever

times 510-($-$$) db 0
dw 0xaa55

