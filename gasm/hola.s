# ----------------------------------------------------------------------------------------
# Writes "Hola, mundo" to the console using a C library. Runs on Linux or any other system
# that does not use underscores for symbols in its C library. To assemble and run:
# On the linux,arguments -no-pie for PIE object error
#     gcc hola.s && ./a.out
# ----------------------------------------------------------------------------------------

.global main
message:
    .asciz "Hola World"            # asciz puts a 0 byte at the end
.text
main:                                   # This is called by C library's startup code
    mov     $message, %rdi          # First integer (or pointer) parameter in %rdi
    call    puts                    # puts(message)
    ret                             # Return to C library code
