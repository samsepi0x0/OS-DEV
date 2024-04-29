;
; A simple boot sector program that demonstrates segment offsetting
;

; ORG is not defined, bios does not know where the hello string is defined.

mov ah, 0x0e

mov al, [hello]       ; This wont work
int 0x10

mov bx, 0x7c0         ; set data segment register ds to 0x7c0
mov ds, bx            ; cant directly write stuff to ds, have to first send value to a register and then to the segment register
mov al, [hello]
int 0x10

mov al, [es:hello]    ; this wont work as es is not defined. ES: extra segment register.
int 0x10

mov bx, 0x7c0         ; define es with 0x7c0 and the code will work.
mov es, bx
mov al, [es:hello]
int 0x10

jmp $

hello:
  db "A"

times 510-($-$$) db 0
dw 0xaa55
