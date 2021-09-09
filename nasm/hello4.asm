section .data
	text db "Hello, World!",10,0

section .text
	global _start

_start:
	mov rax, text ; rax store the string buffer address
	call _print

	mov rax, 60 ;set the sys_exit
	mov rdi, 0 ; set the return code
	syscall ;call the sys_exit

;input: rax as pointer to string
;output: print string at rax
_print:
	push rax ;store the rax for futher use
	mov rbx, 0 ;rax as a counter, how long string is
	; if the section no ret instruction, the code flow will continue to execut
_print_loop:
	;this loop counter the string lenght by move the srting pointer rax
	inc rax ; add the rax, which affect pointer in string
	inc rbx
	mov cl, [rax] ;rax as a pointer which point to the value
	cmp cl ,0 ;if zero, that reach the end of string
	jne _print_loop

	mov rax, 1 ; set the sys_write syscall number 
	mov rdi, 1 ; set where to output buffer
	pop rsi ; pop the value that push into stack before, rax
	mov rdx, rbx ; rbx counter the string length
	syscall

	ret