section .data
    msg db 'Displaying 9 starts',0xa
    len equ $ - msg
    s2 times 9 db '*'
section .text
    global _start

_start:
    mov edx, len    ;msg length
    mov ecx, msg    ;msg to write
    mov ebx, 1      ;file desciptor stdout
    mov eax, 4      ;syscall number
    int 0x80        ;call kernel

    mov	edx, 9    ;message length
    mov	ecx, s2   ;message to write
    mov	ebx, 1    ;file descriptor (stdout)
    mov	eax, 4    ;system call number (sys_write)
    int	0x80     ;call kernel

    mov	eax, 1    ;system call number (sys_exit)
    int	0x80     ;call kernel