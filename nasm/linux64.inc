%include "const.inc"

section .bss
	digitSpace resb 128
	digitSpacePos resb 8
	printSpace resb 8

%macro print 1
	mov rax, %1
	mov [printSpace], rax
;	push rax
	mov rbx, 0
;calculate how many char
%%printLoop:
	mov cl, [rax]
	cmp cl, 0
	je %%endPrintLoop
	inc rbx
	inc rax
	jmp %%printLoop
%%endPrintLoop:
	;call sys_write output to stdin
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, [printSpace]
;	pop rsi
	mov rdx, rbx
	syscall
%endmacro

;the section emulator a stack operation
%macro print_val 1
	mov rax, %1
%%print_rax:
	mov rcx, digitSpace
;	mov rbx, 10
;	mov [rcx], rbx
;	inc rcx
	mov [digitSpacePos], rcx

%%print_rax_loop:
	mov rdx, 0 ; clear dividend
	mov rbx, 10 ;set the divisor base 10(decimal)
	;div rbx; rax/rbx; rax = rax / rbx; rdx = rax % rbx
	div rbx
	push rax ;store the div
	add rdx, 48 ;add with char '0'

	mov rcx, [digitSpacePos] ;get the space address
	mov [rcx], dl ;store lower 8bit
	inc rcx ; mov the spce address positon
	mov [digitSpacePos], rcx ;update the spcace position
	
	pop rax ;get the dividend(result)
	cmp rax, 0;check the div result is zero
	jne %%print_rax_loop

%%print_rax_loop2:
	mov rcx, [digitSpacePos] ;get the space address
	;;each time, ouput a char
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, rcx
	mov rdx, 1 ; write a byte
	syscall

	mov rcx, [digitSpacePos]
	dec rcx ; decrease the address
	mov [digitSpacePos], rcx ;update the address

	cmp rcx, digitSpace ;if reach the bottom address
	jge %%print_rax_loop2

%endmacro

%macro exit 0
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
%endmacro
