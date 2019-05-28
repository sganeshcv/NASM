section .data
msg1 : db 'Enter number of elements : '
l1 : equ $-msg1
msg2 : db ' '
l2 : equ $-msg2
newline : db 10
space : db ' '
zero : db 30h

section .bss
num : resw 1
temp : resb 1
limit : resd 1
array : resw 100
count : resb 1

section .text

;utility function to read a number.
read_num:
	pusha
	mov word[num],0

	loop_read:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		cmp byte[temp],10
		je end_read
		sub byte[temp],30h
		mov ax,word[num]
		mov bx,10
		mul bx
		mov bl,byte[temp]
		mov bh,0
		add ax,bx
		mov word[num],ax
		jmp loop_read
	end_read:
		popa
		ret

;utility funtion to print a number.
print_num:
	mov byte[count],0
	pusha

	extract_no:
		cmp word[num],0
		je print_zero
		inc byte[count]
		mov dx,0
		mov ax,word[num]
		mov bx,10
		div bx
		push dx
		mov word[num],ax
		jmp extract_no
	print_zero:
		cmp byte[count],0
		jne print_no
		mov eax,4
		mov ebx,1
		mov ecx,zero
		mov edx,1
		int 80h
	print_no:
		cmp byte[count],0
		je end_print
		pop dx
		dec byte[count]
		mov byte[temp],dl
		add byte[temp],30h

		
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		
		jmp print_no

	end_print:
		
		mov eax,4
		mov ebx,1
		mov ecx,newline
		mov edx,1
		int 80h

		popa
		ret

;utility function to read an array.
read_array:
	pusha
	
	mov ebx,array
	mov eax,0       ;acts as counter. 
	
	read_array_loop:
		cmp eax,dword[limit]
		je end_read_array
		call read_num
		mov cx,word[num]
		mov word[ebx + 2*eax],cx
		inc eax
		jmp read_array_loop	
	end_read_array:
		popa
		ret

;utility function to print an array.
print_array:
	pusha
	mov ebx,array
	mov eax,0
	print_array_loop:
		cmp eax,dword[limit]
		je end_print_loop
		mov cx,word[ebx + 2*eax]
		mov word[num],cx
		call print_num
		inc eax
		jmp print_array_loop
	end_print_loop:
		popa
		ret


global _start:
_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	call read_num
	movzx eax,word[num]
	mov dword[limit],eax

	;call print_num

	

	call read_array
	;call print_array

	mov eax,1
	mov ebx,0
	int 80h
	
