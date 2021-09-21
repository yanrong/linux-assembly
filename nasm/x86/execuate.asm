;SECTION .data
;command         db      '/bin/ls', 0h       ; command to execute
;arg1            db      '-l', 0h
section .data
    command db '/bin/echo',0h
    arg1 db 'Hello World',0h
    arguments   dd command
                dd arg1
                dd 0h
    enviroment dd 0h

section .text
    global _start
_start:
    mov edx, enviroment
    mov ecx, arguments
    mov ebx, command
    mov eax, 11
    int 80h

    mov ebx, 0
    mov eax, 1
    int 80h