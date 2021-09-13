%include "linux64.inc"
 
section .data
    texta db "Argument(s): ",0
    textb1 db "Argument #",0
    textb2 db ": ",0
    newline db 10,0
 
section .bss
    argc resb 8
    arg_pos resb 8
 
section .text
    global _start
 
_start:
    ;arg position start from 0
    mov rax, 0
    mov [arg_pos], rax
 
    print texta
    ;pop top of the arguments stack,that is arguments number
    pop rax
    mov [argc], rax
    print_val rax
    print newline
 
_print_args_loop:
    print textb1 ;print msg

    mov rax, [arg_pos]
    inc rax ;incrment the pos
    mov [arg_pos], rax ;record updated position

    print_val rax
    print textb2

    pop rax ;get the passed arguments
    print rax
    print newline
 
    mov rax, [arg_pos]
    mov rbx, [argc]
    cmp rax, rbx ;compare the postion and counter
    jne _print_args_loop
 
    exit