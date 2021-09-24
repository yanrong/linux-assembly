section .data
    msg db 'Factorial 3 is :', 0xa
    len equ $-msg

section .bss
    fact resb 1

section .text
    global _start

_start:
    mov bx, 3
    call proc_fact
    add ax, 30h ; convert a number to ASCII code ?
    mov [fact], ax

    mov	  edx, len        ;message length
    mov	  ecx, msg        ;message to write
    mov	  ebx, 1          ;file descriptor (stdout)
    mov	  eax, 4          ;system call number (sys_write)
    int	  0x80           ;call kernel

    mov   edx, 1          ;message length
    mov	  ecx, fact       ;message to write
    mov	  ebx, 1          ;file descriptor (stdout)
    mov	  eax, 4          ;system call number (sys_write)
    int	  0x80           ;call kernel

    mov	  eax, 1          ;system call number (sys_exit)
    int	  0x80           ;call kernel

; the Following code emulate the function call recurse,
; f**k such boring, in assembly recurese always push the
; temporary data to the stack and pop return when finished
; the demo just show for example, never do such f**k code
proc_fact:
    cmp bl, 1 ; if greator 1
    jg do_calculation ;jump to recurse calculation
    mov ax, 1 ; else if reach the bottom 1, return 1
    ret

do_calculation:
    dec bl ;at first
    call proc_fact
    inc bl
    mul bl
    ret