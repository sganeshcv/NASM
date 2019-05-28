section .data
	m1: db "Enter string: "
	l1: equ $-m1
	m2: db 'The words: '
	l2: equ $-m2
	new_line: db 10
	white_space: db 32

section .bss
	string1: resb 50
	string2: resb 50
	string3: resb 50
	temp: resb 1
	len: resw 1
	j: resd 1
	i: resd 1
	size3: resd 1
	size1: resd 1
	size2: resd 1

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

print_space:
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
	mov  eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
	popa
	ret

read_string1:
	pusha
	mov eax,0
	
	read_string1_loop:
		call read_temp
		cmp byte[temp],10
		je end_read_string1_loop
		mov bl,byte[temp]
		mov byte[eax+string1],bl
		inc eax
		jmp read_string1_loop

	end_read_string1_loop:
		mov dword[size],eax
		popa
		ret

read_string2:
	pusha
	mov eax,0
	
	read_string2_loop:
		call read_temp
		cmp byte[temp],10
		je end_read_string2_loop
		mov bl,byte[temp]
		mov byte[eax+string2],bl
		inc eax
		jmp read_string2_loop

	end_read_string2_loop:
		mov dword[size],eax
		popa
		ret

print_string1:
	pusha
	mov eax,0
	
	print_string1_loop:
		cmp eax,dword[size]
		jnb end_print_string1_loop
		mov bl,byte[string1+eax]
		mov byte[temp],bl
		call print_temp
		inc eax
		jmp print_string1_loop
	
	end_print_string1_loop:
		popa
		ret

print_string2:
	pusha
	mov eax,0
	
	print_string2_loop:
		cmp eax,dword[size]
		jnb end_print_string2_loop
		mov bl,byte[string2+eax]
		mov byte[temp],bl
		call print_temp
		inc eax
		jmp print_string2_loop
	
	end_print_string2_loop:
		popa
		ret

print_lexically:
	pusha
	mov eax,0
	mov ebx,0

		loop1:
			cmp eax,dword[size1]
			jnb end_word1
			cmp ebx,dword[size2]
			jnb end_word2
			mov cl,byte[string1+eax]
			mov dl,byte[string2+ebx]
			cmp cl,dl
			jb print1
			cmp cl dl
			ja print2
			
