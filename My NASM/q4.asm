section .data

	messg1 : db 'Enter first digit: ',10
	size_messg1 : equ $-messg1
	messg2 : db 'Enter next digit: ',10
	size_messg2 : equ $-messg2

section .bss

	ele1 : resb 1
	ele2 : resb 1
	junk : resb 1
	ans1 : resb 1
	ans2 : resb 1

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
		mov ecx,ele1
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
                mov ecx,ele2
                mov edx,1
                int 80h

		sub byte[ele1],30h
		sub byte[ele2],30h
		mov ax, word[ele1]
		add ax, word[ele2]

		mov bl,10
		mov ah,0
		div bl

		mov byte[ans1],al
		mov byte[ans2],ah
		add byte[ans1],30h
		add byte[ans2],30h

                mov eax,4
                mov ebx,1
                mov ecx,ans1
                mov edx,1
                int 80h

                mov eax,4
                mov ebx,1
                mov ecx,ans2
                mov edx,1
                int 80h
		
                mov eax,1
                mov ebx,0
                int 80h

