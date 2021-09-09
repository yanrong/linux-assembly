section .data
	text db "Hello, World!",10

section .text
	global _start

_start:
	mov rax, 1 ;set syscall number
	mov rdi, 1 ;set will msg to output
	mov rsi, text ;set the buffer data address
	mov rdx, 14 ;set the buffer length
	syscall ;call the syscall sys_write

	mov rax, 60 ;set the sys_exit
	mov rdi, 0 ; set the return code
	syscall ;call the sys_exit