section .bss
	digit_space resb 100
	digit_space_pos resb 8

section .text
	global _start

_start:
	mov rax, 123
	call _print_rax

	mov rax, 60
	mov rdi, 0
	syscall

_print_rax:
	mov rcx, digit_space ;store the digit space
	mov rbx, 10 ; add a new line
	mov [rcx], rbx ;add the new line to pointer in reg rcx
	inc rcx ; move the digit buffer index
	mov [digit_space_pos], rcx ;record the new buffer index into buffer

_print_rax_loop:
	mov rdx, 0
	mov rbx, 10
	;Always divides the 64 bits value accross edx:eax by a value.
	;The result of the division is stored in eax and the remainder in edx.
	div rbx
	push rax ;store the division
	add rdx, 48 ;48 in ASCII is character '0'

	mov rcx, [digit_space_pos] ;get the buffer index
	mov [rcx], dl ;a char's mem space is 8bit, 8 bit dl(dx)
	inc rcx ;move the buffer index
	mov [digit_space_pos], rcx ;update label address

	pop rax ;reload the division to rax
	cmp rax, 0 ;if the division is not zero, repreat the previous step
	jne _print_rax_loop

_print_rax_loop2:
	mov rcx, [digit_space_pos] ;load the division buffer
	mov rax, 1 ;syscall number
	mov rdi, 1 ;output to stdout
	mov rsi, rcx ;output msg in division buffer
	mov rdx, 1 ;output msg length
	syscall

	mov rcx, [digit_space_pos] ;load the buffer address
	dec rcx ; move back
	mov [digit_space_pos], rcx ; store the current back pointer

	cmp rcx, digit_space ;check it if
	jge _print_rax_loop2 ; the judge is not to reasonable

	ret