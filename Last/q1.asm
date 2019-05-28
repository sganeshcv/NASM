section .data
	m1 : db "Enter the radius: "
	l1 : equ $-m1
	m2 :db "Perimeter is: "
	l2 : equ $-m2
	format1 : db "%lf",0
	format2 : db "%lf",10
	new_line : db 10

section .bss
	float1 :resq 1
	limit :resd 1
	array :resq 100
	

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


read_float:
	push ebp
	mov ebp,esp
	sub esp,8
	lea eax,[esp]
	push eax
	push format1
	call scanf
	fld qword[ebp-8]
	mov esp,ebp
	pop ebp
	ret

print_float:
	push ebp
	mov ebp,esp
	sub esp,8
	fst qword[ebp-8]
	push format2
	call printf
	mov esp,ebp
	pop ebp
	ret

global main:
extern scanf
extern printf

main:
	mov eax,4
	mov ebx,1
	mov ecx,m1
	mov edx,l1
	int 80h

	call read_num
	movzx eax,word[num]
	mov dword[limit],eax
	fstp qword[float1]

	mov eax,4
	mov ebx,1
	mov ecx,m2
	mov edx,l2
	int 80h

	ffree ST0

	mov eax,1
	mov ebx,0
	int 80h
