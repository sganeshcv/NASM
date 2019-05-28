section .data

	messg1 : db 'Enter the fisrt number:  ',10
	size_messg1 : equ $-messg1
	messg2 : db 'Enter the second number: ',10
	size_messg2 : equ $-messg2

section .bss

	x : resb 1
	y : resb 1
	junk : resb 1

section .text

	global _start:
		_start:

			mov eax,4
			mov ebx,1
			mov ecx,messg1
			mov edx,size_messg1
			int 80h

			mov eax,3
			mov ebx,0
			mov ecx,x
			mov edx,1
			int 80h

			mov eax,3
			mov ebx,0
			mov ecx,junk
			mov edx,1
			int 80h

			mov eax,4
			mov ebx,1
			mov ecx,messg2
			mov edx,size_messg2
			int 80h

			mov eax,3
			mov ebx,0
			mov ecx,y
			mov edx,1
			int 80h

			sub byte[x],30h
			sub byte[y],30h
			mov al,byte[x]
			cmp al,byte[y]
			jg ifxy
			add byte[y],30h
			
			mov eax,4
			mov ebx,1
			mov ecx,y
			mov edx,1
			int 80h
			jmp exit

		ifxy:
			add byte[x],30h
			mov eax,4
			mov ebx,1
			mov ecx,x
			mov edx,1
			int 80h
			jmp exit
	
		exit:
			mov eax,1
			mov ebx,0
			int 80h
