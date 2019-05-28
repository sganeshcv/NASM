section .data
	m1 : db 'Enter the string',10
	l1 : equ $-m1
	new_line : db 10
	m2 : db 'The size: '
	l2 : equ $-m2
	
section .bss
	length : resd 1
	str : resb 100
	temp : resb 1
	count : resb 1
	

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
	mov dword[length],0
	mov byte[count],0
	mov eax,0

	read_str_loop:
		call read_temp
		cmp byte[temp],10
		je end_read_str_loop
		mov bl,byte[temp]
		mov byte[str+eax],bl
		inc eax
		inc byte[count]
		jmp read_str_loop

	end_read_str_loop:
		mov dword[length],eax
		popa
		ret

print_str:
	pusha
	mov eax,0

	print_str_loop:
		cmp eax,dword[length]
		jnb end_print_str_loop
		mov bl,byte[str+eax]
		mov byte[temp],bl
		call print_temp
		inc eax
		jmp print_str_loop

	end_print_str_loop:
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
		call print_str
		
		mov eax,4
		mov ebx,1
		mov ecx,m2
		mov edx,l2
		int 80h
	
		mov al,byte[count]
		add al,30h
		mov byte[temp],al
		call print_temp
		call print_new_line
		
		mov eax,1
		mov ebx,0
		int  80h
