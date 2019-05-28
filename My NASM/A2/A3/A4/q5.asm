section .data
	m1: db "Enter string: "
	l1: equ $-m1
	m2: db 'The words: '
	l2: equ $-m2
	new_line: db 10
	white_space: db 32

section .bss
	string: resb 50
	temp: resb 1
	len: resw 1
	j: resd 1
	i: resd 1
	size: resd 1
	
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

read_string:
	pusha
	mov eax,0
	
	read_string_loop:
		call read_temp
		cmp byte[temp],10
		je end_read_string_loop
		mov bl,byte[temp]
		mov byte[eax+string],bl
		inc eax
		jmp read_string_loop

	end_read_string_loop:
		mov dword[size],eax
		popa
		ret
print_string:
	pusha
	mov eax,0
	
	print_string_loop:
		cmp eax,dword[size]
		jnb end_print_string_loop
		mov bl,byte[string+eax]
		mov byte[temp],bl
		call print_temp
		inc eax
		jmp print_string_loop
	
	end_print_string_loop:
		popa
		ret

print_ij:
	pusha
	mov eax,dword[i]

		loopp:
			cmp eax,dword[j]
			ja end_loopp
			mov cl,byte[string+eax]
			mov byte[temp],cl
			call print_temp
			inc eax
			jmp loopp

		end_loopp:
			call print_space
			popa
			ret

rev_print:
	pusha
	mov eax,dword[size]
	dec eax

	loop1:
		cmp eax,0
		je end_loop1
		mov ebx,eax
		
		loop2:
			cmp ebx,0
			je print_word_zero
			cmp byte[string+ebx],32
			je print_word
			dec ebx
			jmp loop2

		print_word:
			mov dword[i],ebx
			inc dword[i]
			mov dword[j],eax
			call print_ij
			dec ebx
			mov eax,ebx
			jmp loop1

		print_word_zero:
			mov dword[i],ebx
			mov dword[j],eax
			call print_ij
			jmp end_loop1
			

	end_loop1:
		popa
		ret
		

global _start:
_start:
	
	mov eax,4
	mov ebx,1
	mov ecx,m1
	mov edx,l1
	int 80h
	
	call read_string
	
	call print_new_line

	call rev_print

	call print_new_line

	mov eax,1	
	mov ebx,0
	int 80h

