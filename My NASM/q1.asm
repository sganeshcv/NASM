section .data

name : db 'Sreeganesh',10
size_name : equ $-name

addr1 : db 'MPV',10
size_addr1 : equ $-addr1

addr2 : db 'Trivandrum',10
size_addr2 : equ $-addr2

section .text

global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,name
	mov edx,size_name
	int 80h

        mov eax,4
        mov ebx,1
        mov ecx,addr1
        mov edx,size_addr1
        int 80h
        mov eax,4
        mov ebx,1
        mov ecx,addr2
        mov edx,size_addr2
        int 80h


	mov eax,1
	mov ebx,0
	int 80h

