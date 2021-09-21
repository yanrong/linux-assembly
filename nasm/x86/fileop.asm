%include 'functions3.asm'
section .data
    filename db 'test.txt', 0h    ; the filename to create
    contents db 'Hello world!', 0h  ; the contents to write

section .bss
    buf resb 255,          ; variable to store file contents

section .text
    global  _start

_start:

    mov     ecx, 0777o          ; Create file
    mov     ebx, filename
    mov     eax, 8
    int     80h

    mov     edx, 12             ; Write contents to file
    mov     ecx, contents
    mov     ebx, eax
    mov     eax, 4
    int     80h

    mov     ecx, 0              ; Open file
    mov     ebx, filename
    mov     eax, 5
    int     80h

    mov     edx, 12             ; Read file
    mov     ecx, buf
    mov     ebx, eax            ; load file desciptor to ebx
    mov     eax, 3
    int     80h

    mov     eax, buf
    call    sprintLF

    mov     ebx, ebx            ; not needed but used to demonstrate that SYS_CLOSE takes a file descriptor from EBX
    mov     eax, 6              ; invoke SYS_CLOSE (kernel opcode 6)
    int     80h                 ; call the kernel

    call    quit                ; call our quit function