;
; a simple boot sector that prints message using BIOS routines
;

mov ah, 0x0e  ; int 10/ah = 0x0e -> scrolling teletype BIOS routine

mov al, 'H'
int 0x10
mov al, 'o'
int 0x10
mov al, 'w'
int 0x10
mov al, 'd'
int 0x10
mov al, 'y'
int 0x10
mov al, '?'
int 0x10

jmp $         ; Jump to the current address forever.

;
; Pad the sector and add magic bytes
;

times 510-($-$$) db 0 ; padding with 0s

dw 0xaa55
