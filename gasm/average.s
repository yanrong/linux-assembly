.global main
.data
    count: .quad 0
    sum: .quad 0
    format: .asciz "%g\n"
    error: .asciz "There are no command line arguments to average\n"
.text
main:
    dec %rdi                    # argv[0] is the program's name, skip it
    jz nothingToAverage
    mov %rdi, count             # save number of real arguments

accumalte:
    push %rdi                   # save register across call to atoi
    push %rsi
    mov (%rsi, %rdi, 8), %rdi   # argv[rdi]
    call atoi                   # now rax has the int value of arg
    pop %rsi
    pop %rdi                    # restore registers after atoi call
    add %rax, sum               # accumulate sum as we go, rax hold the return value in atoi
    dec %rdi                    # count down
    jnz accumalte

average:
    # convert double intger to double float point
    # SIMD XMM instruction
    cvtsi2sd sum, %xmm0
    cvtsi2sd count, %xmm1
    divsd %xmm1, %xmm0          # xmm0 is sum/count
    mov $format, %rdi           # 1st arg to printf
    mov $1, %rax                # printf is varargs, there is 1 non-int argument

    sub $8, %rsp                # align stack pointer
    call printf                 # printf(format, sum/count)
    add $8, %rsp                # restore stack pointer

    ret

nothingToAverage:
    mov $error, %rdi
    xor %rax, %rax
    call printf
    ret
