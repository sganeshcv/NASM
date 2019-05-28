section .data

messg1 : db 'Enter value of n: ',10
size_messg1 : equ $-messg1
w_space : db ' '
size_w_space :equ $-w_space

section .bss

n1 : resb 1
counter : resb 1

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
		mov ecx,n1
		mov edx,1
		int 80h
		sub byte[n1],30h
		mov byte[counter],1
	
		for:
			add byte[counter],30h
		        mov eax,4
	       	 	mov ebx,1
	        	mov ecx,counter
	        	mov edx,1
	        	int 80h
                	mov eax,4
                	mov ebx,1
                	mov ecx,w_space
        	        mov edx,size_w_space
	                int 80h
			sub byte[counter],30h
			add byte[counter],1
			mov al,byte[counter]
			cmp al,byte[n1]
			jna for

		mov eax,1
		mov ebx,0
		int 80h

