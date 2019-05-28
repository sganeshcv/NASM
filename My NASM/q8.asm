section .data
	msg1 : db 'Enter the number: '
	size_msg1 : equ $-msg1
	msg_odd : db 'The given number is odd.',10
	size_msg_odd : equ $-msg_odd
	msg_even : db 'The given number is even.',10
	size_msg_even : equ $-msg_even

section .bss
	x : resb 1

section .text
	global _start:
		_start:
			mov eax,4
			mov ebx,1
			mov ecx,msg1
			mov edx,size_msg1
			int 80h

			mov eax,3
			mov ebx,0
			mov ecx,x
			mov edx,1
			int 80h

			sub word[x],30h
			mov ax,word[x]
			mov bl,2
			mov ah,0
			div bl
			cmp ah,0
			je even
			mov eax,4
			mov ebx,1
			mov ecx,msg_odd
			mov edx,size_msg_odd
			int 80h
			jmp exit
		
		even:
			mov eax,4
			mov ebx,1
			mov ecx,msg_even
			mov edx,size_msg_even
			int 80h
			jmp exit

		exit:
			mov eax,1
			mov ebx,0
			int 80h
