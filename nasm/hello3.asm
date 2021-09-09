section .data
	text1 db "What is your name? "
	text2 db "Hello, "

section .bss
	name resb 16

section .text
	global _start

_start:
	call _print_text1
	call _get_name
	call _print_text2
	call _print_name
	

	mov rax, 60 ;set the sys_exit
	mov rdi, 0 ; set the return code
	syscall ;call the sys_exit

_get_name:
	mov rax, 0 ; call sys_read
	mov rdi, 0 ; get the data from stdin
	mov rsi, name
	mov rdx, 16
	syscall
	ret

_print_text1:
	mov rax, 1 ;set syscall number
	mov rdi, 1 ;set will msg to output
	mov rsi, text1 ;set the buffer data address
	mov rdx, 19 ;set the buffer length
	syscall ;call the syscall sys_write
	ret

_print_text2:
	mov rax, 1 ;set syscall number
	mov rdi, 1 ;set will msg to output
	mov rsi, text2 ;set the buffer data address
	mov rdx, 7 ;set the buffer length
	syscall ;call the syscall sys_write
	ret

_print_name:
	mov rax, 1 ;set syscall number
	mov rdi, 1 ;set will msg to output
	mov rsi, name ;set the buffer data address
	mov rdx, 16 ;set the buffer length
	syscall ;call the syscall sys_write
	ret