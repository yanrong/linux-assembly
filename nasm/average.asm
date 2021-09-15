global main
extern atoi
extern printf
default rel

section .text
main:
    dec     rdi             ; argc-1, since we don't count program name
    jz      nothingToAverage
    mov     [count], rdi    ; save number of real arguments
accumulate:
    push    rdi             ; save register across call to atoi
    push    rsi
    mov     rdi, [rsi+rdi*8]  ; argv[rdi]
    call    atoi            ; now rax has the int value of arg
    pop     rsi             ; restore registers after atoi call
    pop     rdi
    add     [sum], rax      ; accumulate sum as we go
    dec     rdi             ; count down
    jnz     accumulate      ; more arguments?
average:
;Convert Doubleword Integer to Scalar Double-Precision Floating-Point Value
    cvtsi2sd xmm0, [sum]
    cvtsi2sd xmm1, [count]
    divsd   xmm0, xmm1      ; xmm0 is sum/count
    mov rdi, format         ; 1st arg to printf
    mov rax, 1              ; printf is varargs, there is 1 non-int argument

    sub rsp, 8              ; align stack pointer
    call printf             ; printf(format, sum/count)
    add rsp, 8              ; restore stack pointer

    ret
nothingToAverage:
    mov rdi, error
    xor rax, rax
    call printf
    ret

section .data
count:  dq       0
sum:    dq       0
format: db       "%g", 10, 0
error:  db       "There are no command line arguments to average", 10, 0