section .data
msg1 : db 'Enter number : '
l1 : equ $-msg1
newline : db 10
space : db ' '
zero : db 30h

section .bss
num : resw 1
n : resw 1
m : resw 1
j : resw 1
i : resw 1
temp : resb 1
limit : resd 1
array : resw 100
t_array : resw 100
count : resb 1
mn1 : resw 1


section .text

print_space:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,1
	int 80h
	popa
	ret

print_new_line:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	popa
	ret

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
		call print_space
		popa
		ret


read_array:
	pusha
	mov eax,0
	mov ebx,array
	mov word[i],0
	
	i_loop:
		mov cx,word[i]
		cmp cx,word[m]
		jnb end_i_loop
		mov word[j],0

		j_loop:
			mov cx,word[j]
			cmp cx,word[n]
			jnb end_j_loop
			call read_num
			mov dx,word[num]
			mov word[ebx+2*eax],dx
			inc eax
			inc word[j]
			jmp j_loop

		end_j_loop:
			inc word[i]
			jmp i_loop

	end_i_loop:
		popa
		ret

print_array:
	pusha
	mov eax,0
	mov ebx,array
	mov word[i],0

	ip_loop:
		mov cx,word[i]
		cmp cx,word[m]
		jnb end_ip_loop
		mov word[j],0

		jp_loop:
			mov cx,word[j]
			cmp cx,word[n]
			jnb end_jp_loop
			mov cx,word[ebx+2*eax]
			mov word[num],cx
			call print_num
			inc eax
			inc word[j]
			jmp jp_loop

		end_jp_loop:
			call print_new_line
			inc word[i]
			jmp ip_loop

	end_ip_loop:
		popa
		ret

print_t_array:
	pusha
	mov eax,0
	mov ebx,t_array
	mov word[i],0

	ipt_loop:
		mov cx,word[i]
		cmp cx,word[n]
		jnb end_ipt_loop
		mov word[j],0

		jpt_loop:
			mov cx,word[j]
			cmp cx,word[m]
			jnb end_jpt_loop
			mov cx,word[ebx+2*eax]
			mov word[num],cx
			call print_num
			inc eax
			inc word[j]
			jmp jpt_loop

		end_jpt_loop:
			call print_new_line
			inc word[i]
			jmp ipt_loop

	end_ipt_loop:
		popa
		ret


multiply_mn:
	pusha
	mov ax,word[n]
	mov bx,word[m]
	mul bx
	mov word[mn1],ax
	popa
	ret

transpose_matrix:
	pusha
	mov eax,0
	mov ebx,0
	mov word[i],0
	call multiply_mn;

	it_loop:
		mov cx,word[i]
		cmp cx,word[n]
		jnb end_it_loop
		mov word[j],cx
		
		jt_loop:
			mov cx,word[j]
			cmp cx,word[mn1]
			jnb end_jt_loop
			movzx edx,word[j]
			mov cx,word[array+2*edx]
			mov word[t_array+2*eax],cx
			inc eax
			mov cx,word[j]
			add cx,word[n]
			mov word[j],cx
			jmp jt_loop

		end_jt_loop:
			inc word[i]
			jmp it_loop
	end_it_loop:
		popa
		ret

global _start:
	_start:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,l1
		int 80h

		call read_num;
		mov cx,word[num]
		mov word[m],cx

	
                mov eax,4
                mov ebx,1
                mov ecx,msg1
                mov edx,l1
                int 80h

                call read_num;
                mov cx,word[num]
                mov word[n],cx

		
		call read_array

		;call multiply_mn
		;mov cx,word[mn]
		;mov word[num],cx
		;call print_num
		call print_new_line
		call print_array
		call transpose_matrix
		call print_new_line
		call print_t_array
		mov eax,1
		mov ebx,0
		int 80h
