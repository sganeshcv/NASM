section .data

	messg1 : db 'Enter tens digit of first number: '
	size_messg1 : equ $-messg1
	messg2 : db 'Enter unit digit of the first number: '
	size_messg2 : equ $-messg2
	messg3 : db 'Enter tens digit of second number: '
	size_messg3 : equ $-messg3
	messg4 : db 'Enter the unit digit of the second number: '
	size_messg4 : equ $-messg4

section .bss

	x1 : resb 1
	x2 : resb 1
	y1 : resb 1
	y2 : resb 1
	junk : resb 1
	ans1 : resb 1
	ans2 : resb 1
	ans3 : resb 1
	ans4 : resb 1
	n1 : resb 1
	n2 : resb 1

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
		mov ecx,x1
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
                mov ecx,x2
                mov edx,1
                int 80h


		mov eax,3
                mov ebx,0
                mov ecx,junk
                mov edx,1
                int 80h

		;n1

		sub byte[x1],30h
		mov al,byte[x1]
		mov bl,10
		mov ah,0
		mul bl
		sub word[x2],30h
		mov bx,word[x2]
		add ax,bx
		mov [n1],ax

                mov eax,4
                mov ebx,1
                mov ecx,messg3
                mov edx,size_messg3
                int 80h

                mov eax,3
                mov ebx,0
                mov ecx,y1
                mov edx,1
                int 80h

                mov eax,3
                mov ebx,0
                mov ecx,junk
                mov edx,1
                int 80h

                mov eax,4
                mov ebx,1
                mov ecx,messg4
                mov edx,size_messg4
                int 80h

                mov eax,3
                mov ebx,0
                mov ecx,y2
                mov edx,1
                int 80h

                mov al,byte[y1]
		sub al,30h
                mov bl,10
                mov ah,0
                mul bl
                mov bx,word[y2]
		sub bx,30h
                add ax,bx

		add ax,word[n1]
		
		mov bl,100
		mov ah,0
		div bl

		mov [ans1],al
		mov [ans4],ah
		mov ax,word[ans4]
		
                mov bl,10
                mov ah,0
                div bl

		mov byte[ans2],al
		mov byte[ans3],ah 

		add byte[ans1],30h
		add byte[ans2],30h
		add byte[ans3],30h

		mov eax, 4
		mov ebx, 1
		mov ecx, ans1
		mov edx, 1
		int 80h
	
		mov eax, 4
		mov ebx, 1
		mov ecx, ans2
		mov edx, 1
		int 80h

                mov eax, 4
                mov ebx, 1
                mov ecx, ans3
                mov edx, 1
                int 80h
	
		mov eax, 1
		mov ebx, 0
		int 80h
	
