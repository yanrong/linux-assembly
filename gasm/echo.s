# -----------------------------------------------------------------------------
# A 64-bit program that displays its commandline arguments, one per line.
#
# On entry, %rdi will contain argc and %rsi will contain argv.
# -----------------------------------------------------------------------------
.global main

format:
    .asciz "%s\n"

.text
main:
    push    %rdi                    # save registers that puts uses
    push    %rsi
    sub     $8, %rsp                # must align stack before call

    mov     (%rsi), %rdi            # the argument string to display
    call    puts                    # print it

    add     $8, %rsp                # restore %rsp to pre-aligned value
    pop     %rsi                    # restore registers puts used
    pop     %rdi

    add     $8, %rsi                # point to next argument,64bitregister, move to next
    dec     %rdi                    # count down
    jnz     main                    # if not done counting keep going

    ret
