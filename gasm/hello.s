# ----------------------------------------------------------------------------------------
# Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
# To assemble and run:
#     gcc  -c hello.s && ld hello.o && ./a.out
# or
#     gcc -nostdlib hello.s && ./a.out
# -------------------------------------------------------------------------------------

message:
    .ascii "Hello World!\n"

.global _start

.text
_start:
    # write(1, message, 13)
    mov $1, %rax        # system call 1 is write
    mov $1, %rdi        # file handle 1 is stdout
    mov $message, %rsi  # address of string to output
    mov $13, %rdx       # number of bytes
    syscall

    # exit (0)
    mov $60, %rax
    # mov %0, %rdi #error
    xor %rdi, %rdi
    syscall
