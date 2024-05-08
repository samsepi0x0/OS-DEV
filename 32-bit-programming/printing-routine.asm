[bits 32]
; define constants
VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:                ; label for printing string in 32 bit mode.
  pusha                         ; store copy of all registers in ram
  mov edx, VIDEO_MEM            ; initialize by moving to video memory address

print_string_pm_loop:           ; loop print value in ebx while end != 0x00 
  mov al, [ebx]                 ; move the value to be printed to AL
  mov ah, WHITE_ON_BLACK        ; set foreground and background color

  cmp al, 0x0                   ; check if value is 0x0, if yes, printing is completed.
  je print_string_pm_done

  mov [edx], ax                 ; else store the current attributes (value + coloring)
                                ; at the memory stored at edx (video memory)
  add ebx, 0x01                 ; increment to next character to be printed
  add edx, 0x02                 ; move 2 bytes, i.e. the next memory location to stored
                                ; the next character along with its properties.
  jmp print_string_pm_loop

print_string_pm_done:
  popa                          ; printing is done, set original values of the registers.
  ret                           ; set IP to calling instruction + 1
