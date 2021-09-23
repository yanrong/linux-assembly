section	.bss
    num resb 1
section	.text
    global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point
    mov ecx,10
    mov eax, '1'

l1:
    mov [num], eax
    mov eax, 4
    mov ebx, 1
    push ecx ; for loop instruction, ecx default as loop count

    mov ecx, num
    mov edx, 1
    int 0x80

    mov eax, [num]
    sub eax, '0'
    inc eax
    add eax, '0'
    pop ecx ; if the count is zero, the loop will be terminate
    loop l1 ;a loop instruction

    mov eax,1             ;system call number (sys_exit)
    int 0x80              ;call kernel
