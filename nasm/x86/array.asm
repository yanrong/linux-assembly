section .data
    global x
x: ; dfine a byte array
    db 2
    db 3
    db 4
sum:
    db 0
section .text
    global _start

_start:
    mov eax, 3 ;number bytes in arrays
    mov ebx, 0 ;store the sum
    mov ecx, x ;ecx point to the begin address of the array

.loop:
    add ebx, [ecx] ; accumalte the result to ebx
    add ecx, 1 ; move the pointer to next
    dec eax ; counter decrease
    jnz .loop

.done:
    add ebx, '0' ; ? what f***, to ascill ?
    mov [sum], ebx

display:
    mov  edx,1      ;message length
    mov  ecx, sum   ;message to write
    mov  ebx, 1     ;file descriptor (stdout)
    mov  eax, 4     ;system call number (sys_write)
    int  0x80       ;call kernel

    mov  ebx, 0
    mov  eax, 1     ;system call number (sys_exit)
    int  0x80       ;call kernel
