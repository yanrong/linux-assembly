%include "linux64.inc"

section .data
    filename db 'myfile.txt',0
    text db "Here's some text.",10
    textlen equ $-text

section .text
    global _start

_start:
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_CREAT+O_WRONLY
    mov rdx, 0644o
    syscall

    push rax ;store the previous sys_open file descriptor to stack
    mov rdi, rax ;after open file, rax value is the file descriptor
    mov rax, SYS_WRITE ;reload the rax to sys_write
    mov rsi, text
    mov rdx, textlen
    syscall

    mov rax, SYS_CLOSE
    pop rdi ;get the fd from stack
    syscall

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
