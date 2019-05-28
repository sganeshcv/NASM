section .data

	m1 : db 'Enter number: '
	l1 : equ $-m1
	mp : db 'It is prime',10
	l2 : equ $-mp
	mnp : db 'Not prime',10
	l3 : equ $-mnp

section .bss
	n : resb 1
	i : resb 1
	junk : resb 1
	x : resb 1

section .text
		global _start:
		_start:
			mov eax,4
			mov ebx,1
			mov ecx,m1
			mov edx,l1
			int 80h
	
			mov eax,3
			mov ebx,0
			mov ecx,n
			mov edx,1
			int 80h

			sub byte[n],30h
			mov al,byte[n]
			mov byte[i],2
			mov bl,2
			mov ah,0
			div bl
			mov byte[x],al
			inc byte[x]
			mov cl,byte[x]
		
		for: 	
			cmp byte[i],cl
			ja prime
			mov al,byte[n]
			mov bl,byte[i]
			mov ah,0
			div bl
			cmp ah,0
			je nprime
			add byte[i],1
			jmp for

		prime:
			mov eax,4
			mov ebx,1
			mov ecx,mp
			mov edx,l2
			int 80h
			jmp exit

               nprime:
                        mov eax,4
                        mov ebx,1
                        mov ecx,mnp
                        mov edx,l3
                        int 80h
                        jmp exit

		
		exit:
			mov eax,1
			mov ebx,0
			int 80h

