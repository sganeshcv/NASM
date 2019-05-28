section .data
msg1: db "Enter the number of elements: "
size1: equ $-msg1

format1: db "%d",0
format2: db "%lf",0
format3 : db "%lf",10

section .bss
count: resd 1
index: resd 1 
array: resq 100
size : resd 1
num : resw 1

section .text
global main
extern scanf
extern printf

read_array:
pusha
mov dword[index], 0
	loop1:
	mov eax, dword[index]
	cmp eax, dword[size]
	je exit1

	call read_float
	mov eax, dword[index]
	fstp qword[array + eax*8]
	inc dword[index]
	jmp loop1
exit1:
popa
ret

print_array:
pusha
mov dword[index], 0
	loop2:
	mov eax, dword[index]
	cmp eax, dword[size]
	je exit2

	mov eax, dword[index]
	fld qword[array + eax*8]
	call print_float

	inc dword[index]
	jmp loop2
exit2:
popa
ret


read_int:
push ebp
mov ebp, esp
sub esp , 2
lea eax , [esp]
push eax
push format1
call scanf
mov ax, word[ebp-2]
mov word[num], ax
mov esp, ebp
pop ebp
ret

read_float:
push ebp
mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format2
call scanf
fld qword[ebp-8]
mov esp, ebp
pop ebp
ret

print_float:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp-8]
push format3
call printf
mov esp, ebp
pop ebp
ret

main:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 0x80

call read_int
movzx eax, word[num]
mov dword[size], eax

call read_array
call print_array

exit:
mov eax, 1
mov ebx, 0
int 0x80


