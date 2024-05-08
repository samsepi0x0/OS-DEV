; GDT - refer extensively to the diagram of segment descriptor. 
gdt_start:

gdt_null:               ; The mandatory null descriptor required by the CPU at the start.
  dd 0x0                ; dd -> define double word (4 bytes).
  dd 0x0                ; in total 8 bytes structure filled with zeros.

gdt_code:               ; code segment descriptor
  ; base = 0x0, limit = 0xfffff
  ; 1st flags: (preset)1 (privilige)00 (descriptor type)1 -> 1001b
  ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
  ; 2nd flags: (granularity) 1 (32-bit default)1 (64-bit segment)0 (AVL)0 -> 1100b

  dw 0xffff             ; Segment limit bits 0-15
  dw 0x0                ; base address 0-15
  db 0x0                ; base address (16-23)
  db 10011010b          ; 1 flag, type flags
  db 11001111b          ; 2nd flag, segment limit bits (16-19)
  db 0x0                ; base address bits (24-31)

gdt_data:               ; data segment descriptor
  ; similar to code semgent except for type flags
  ; type flags: (code)0 (expand down)0, (writable)1 (accessed)0 -> 0010b
  dw 0xffff             ; segment limit bits 0-15
  dw 0x0                ; base address 0-15
  db 0x0                ; base address 16-23
  db 10010010b          ; 1st flags, type flags
  db 11001111b          ; 2nd flags, segment limit bits (16-19)
  db 0x0                ; base address 24-31

gdt_end:                ; This is put here so that the assembler can calculate the size
                        ; of the GDT for the GDT Descriptor below.

; GDT descriptor
gdt_descriptor:
  dw gdt_end - gdt_start - 0x01
  dd gdt_start

; define some constants for the gdt segment descriptor offsets, which are what segment
; registers contain when it is in protected mode. Eg: DS = 0x10 in PM, the cpu knows that
; segment described at offset 0x10 in our GDT, which is Data segment in this case
; since 0x0 -> NULL, 0x08 -> code, 0x10 -> DATA.

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
