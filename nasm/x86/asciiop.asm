;AAA − ASCII Adjust After Addition
;AAS − ASCII Adjust After Subtraction
;AAM − ASCII Adjust After Multiplication
;AAD − ASCII Adjust Before Division
;instructions do not take any operands and assume the required operand to be in the AL registe
section .data
    msg db 'The Result i: '
    len equ $-msg
section .bss
    res resb 1
section .text
    global _start

_start:	                ;tell linker entry point
    sub     ah, ah      ;clear zero
    mov     al, '9'
    sub     al, '3'
    aas
    or      al, 30h
    mov     [res], ax

    mov	edx,len	        ;message length
    mov	ecx,msg	        ;message to write
    mov	ebx,1	        ;file descriptor (stdout)
    mov	eax,4	        ;system call number (sys_write)
    int	0x80	        ;call kernel

    mov	edx,1	        ;message length
    mov	ecx,res	        ;message to write
    mov	ebx,1	        ;file descriptor (stdout)
    mov	eax,4	        ;system call number (sys_write)
    int	0x80	        ;call kernel

    mov ebx, 0
    mov	eax,1	        ;system call number (sys_exit)
    int	0x80	        ;call kernel