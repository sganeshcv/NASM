section .data
	m1: db "enter the string: "
	l1 equ $-m1
	m2: db "The string is: "
	l2 equ $-m2
	new_line : db 10
	white_space : db 32

section .bss
	str : resb 100
	limit : resd 1
	temp : resb 1
	

section .text

print_new_line:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,new_line
	mov edx,1
	int 80h
	popa
	ret

print_white_space:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,white_space 
	mov edx,1
	int 80h
	popa
	ret

read_temp:
	pusha
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	popa
	ret

print_temp:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
	popa
	ret

read_str:
	pusha
	mov eax,0

	read_loop:
		call read_temp
		cmp byte[temp],10
		je end_read_loop
		mov bl,byte[temp]
		mov byte[str+eax],bl
		inc eax
		jmp read_loop

	end_read_loop:
		mov dword[limit],eax
		popa 
		ret

print_str:
	pusha
	mov eax,0
	
	print_loop:
		cmp eax,dword[limit]
		jnb end_print_loop
		mov bl,byte[str+eax]
		mov byte[temp],bl
		call print_temp
		inc eax
		jmp print_loop

	end_print_loop:
		call print_new_line
		popa
		ret

global _start:
	_start:
	
	mov eax,4
	mov ebx,1
	mov ecx,m1
	mov edx,l1
	int 80h

	call read_str

	mov eax,4
	mov ebx,1
	mov ecx,m2
	mov edx,l2
	int 80h

	call print_str

	mov eax,1
	mov ebx,0
	int 80h

