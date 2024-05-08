;
; A simple program to print the strings
;

print_string:
  mov ah, 0x0e
  pusha
  loop:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    add bx, 0x01
    jmp loop
  end:
    popa
    ret 

print_hex:
  pusha
  
  mov cx, 12
  mov bx, HEX_OUT

  .EXTRACT:
    mov si, dx
    shr si, cl
    and si, 0x0F

    mov al, [bx + si]
    mov ah, 0x0e
    int 0x10

    sub cx, 0x04
  jnc .EXTRACT
  
  popa
  ret

; GLOBAL VARIABLES
HEX_OUT:
  db "0123456789ABCDEF", 0
