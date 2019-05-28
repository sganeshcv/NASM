section .data
	m1: db 'Enter the number: '
	l1: equ $-m1
	m2: db 'Enter the array elements',10
	l2: equ $-m2
	m3: db 'The array elements are: ',10
	l3: equ $-m3
	mp: db 'is prime',10
	lp: equ $-mp
	new_line: db 10
	zero: db 30h
	space: db ' '
	
section .bss
	num : resw 1
	temp  resb 1
	count : resb 1
	array : resw 50
	k : resw 1
	n : resd 1

section .text

	read_num:
		pusha
		mov word[num],0

		loop_read_num:
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			cmp byte[temp],10
			je end_read_num
			sub byte[temp],30h
			mov ax,word[num]
			mov bx,10
			mul bx
			mov bh,0
			mov bl,byte[temp]
			add ax,bx
			mov word[num],ax
			jmp loop_read_num

		end_read_num:
			popa
			ret
	
	print_num:
		pusha
		mov byte[count],0

		extract_num:
			cmp word[num],0
			je print_zero
			mov ax,word[num]
			mov bx,10
			mov dx,0
			div bx
			mov word[num],ax
			push dx
			inc byte[count]
			jmp extract_num

		print_zero:
			cmp byte[count],0
			jne print_n
			mov eax,4
			mov ebx,1
			mov ecx,zero
			mov edx,1
			int 80h

		print_n:
			cmp byte[count],0
			je end_print_num
			pop dx
			dec byte[count]
			mov byte[temp],dl
			add byte[temp],30h
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			jmp print_n

		end_print_num:
			mov eax,4
			mov ebx,1
			mov ecx,new_line
			mov edx,1
			int 80h

			popa
			ret

	read_array:
		pusha
		mov eax,0
		mov ebx,array
			
		loop_read_array:
			cmp eax,dword[n]
			jnb end_read_array
			call read_num
			mov cx,word[num]
			mov word[ebx+2*eax],cx
			inc eax
			jmp loop_read_array

		end_read_array:
			popa
			ret

	print_array:
		pusha
		mov ebx,array
		mov eax,0

		print_array_loop:
			cmp eax,dword[n]
			jnb end_print_array
			mov cx,word[ebx+2*eax]
			mov word[num],cx
			call print_num
			inc eax
			jmp print_array_loop

		end_print_array:
			popa
			ret


	isPrime_num:
		pusha
		mov ax,word[num]
		mov cx,2

		loop_isprime:
			cmp ax,2
			je isprime_print
			cmp cx,ax
			jnb isprime_print
			mov bx,cx
			mov dx,0
			div bx
			cmp dx,0
			je end_isprime
			mov ax,word[num]
			inc cx
			jmp loop_isprime

		isprime_print:
			call print_num
			mov eax,4
			mov ebx,1
			mov ecx,mp
			mov edx,mp
			int 80h
			jmp loop_isprime

		end_isprime:
			popa
			ret
			

	print_prime_array:
		pusha
		mov eax,0
		mov ebx,array

		loop_prime_num:
			cmp eax,dword[n]
			jnb end_prime_num
			mov cx,word[ebx+2*eax]
			mov word[num],cx
			call isPrime_num
			inc eax
			jmp loop_prime_num

		end_prime_num:
			popa
			ret


	global _start:
		_start:
		
		mov eax,4
		mov ebx,1
		mov ecx,m1
		mov edx,l1
		int 80h

		call read_num
		mov cx,word[num]
		movzx eax,cx
		mov dword[n],eax
 		
		mov eax,4
		mov ebx,1
		mov ecx,m2
		mov edx,l2
		int 80h

		call read_array	

		mov eax,4
		mov ebx,1
		mov ecx,m3
		mov edx,l3
		int 80h
		
		call print_array

		call print_prime_array

		mov eax,1
		mov ebx,0
		int 80h
