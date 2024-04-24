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
  ; TODO: manipulate chars of HEX_OUT to reflect DX
  

  mov bx, HEX_OUT
  call print_string

  ret

; GLOBAL VARIABLES
;HEX_OUT:
;  db '0x0000', 0
