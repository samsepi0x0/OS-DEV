;
; A boot sector program to print according to if else conditions.
;

mov bx, 30

cmp bx, 4         ; check if bx < 4
jle printA        ; if true print A

cmp bx, 40        ; else if check if bx < 40
jl printB         ; if true print B

mov al, 'C'       ; else print C
jmp end           ; move towards the end of the codebase

printA:
  mov al, 'A'     ; set Al to A and move to end
  jmp end         

printB:
  mov al, 'B'     ; set Al to B and move to end

end:
  mov ah, 0x0e    ; print the value set in AL
  int 0x10        ; interrupt triggered
  jmp $           ; stay infinitely

  times 510-($-$$) db 0   ; pad the boot sector with 0
  dw 0xaa55               ; last two bytes are magic
