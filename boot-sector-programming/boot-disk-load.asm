;
; Load DH sectors to ES:BX from Drive DL
;

disk_load:
  push dx               ; keep track of how many sectors we want to read
  mov ah, 0x02          ; required by the bios
  mov al, dh            ; read DH sectors
  mov ch, 0x00          ; set cylinder 0
  mov dh, 0x00          ; set head 0
  mov cl, 0x02          ; start reading from 2nd sector.

  int 0x13

  jc disk_error         ; print disk error if carry flag is set

  pop dx                ; retrieved the saved value
  cmp dh, al            ; if (AL = sectors read) != the requested sectors
  jne disk_error        ; raise error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  jmp $

DISK_ERROR_MSG:
  db "Disk Read Error!", 0
