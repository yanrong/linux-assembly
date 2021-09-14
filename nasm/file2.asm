%include "linux64.inc"

section .data
    filename db 'myfile.txt',0

section .bss
    text resb 18

section .text
    global _start

_start:
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    push rax ;store the previous sys_open file descriptor to stack
    mov rdi, rax ;after open file, rax value is the file descriptor
    mov rax, SYS_READ ;reload the rax to sys_write
    mov rsi, text
    mov rdx, 17
    syscall

    mov rax, SYS_CLOSE
    pop rdi ;get the fd from stack
    syscall

    print text
    exit
