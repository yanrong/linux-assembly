%include 'functions3.asm'

section .data
    childMsg db 'This is the child process',0ah
    clen equ  $-childMsg
    parentMsg db 'This is the parant process',0ah
    plen equ $-parentMsg

section .text
    global _start

_start:
    mov eax, 2 ; 2 - fork syscall
    int 0x80 ;call syscall

    cmp eax, 0
    jz child

parant:
    mov ecx, parentMsg
    mov edx, plen
    mov ebx, 1
    mov eax, 4
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h

child:
    mov eax, childMsg
    call sprintLF

    call quit

