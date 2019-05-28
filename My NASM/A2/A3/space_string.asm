section .data
    msg1: db "Enter the string : "
    size1: equ $-msg1
    msg2: db "The number of spaces : "
    size2: equ $-msg2
    nwl : db 10
    msg4 : db "The entered string : "
    size4 : equ $-msg4

section .bss
    string: resb 50
    temp: resb 1
    len:  resw 1
    j: resb 1
    i: resb 1
    num : resw 1
    count : resw 1
    counter :  resb 1

section .text
    global _start:
_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size1
    int 0x80

    call read_string

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, size4
    int 0x80

    call print_string

    ; mov cx, word[len]
    ; mov word[num], cx
    ; call print_num

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size2
    int 0x80
    
    call check_space


    ;EXIT
    mov eax, 1
    mov ebx, 0
    int 0x80

read_string:
pusha
mov word[len], 0
reading:

    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
  
    mov al, byte[temp]
    cmp al, 10
    je end_reading

    movzx ecx, word[len]
    mov byte[string + ecx], al
    inc word[len]
    jmp reading

end_reading:
popa
ret


print_string:
pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, string
    movzx edx, byte[len]
    int 80h

    ; mov eax, 4
    ; mov ebx, 1
    ; mov ecx, nwl
    ; mov edx, 1
    ; int 0x80

popa
ret

;TEMPORARY
print_char:
pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 0x80
popa
ret

check_space:
pusha
mov byte[counter], 0
mov byte[i], 0 
    check_space_loop:
    movzx eax, byte[i]
    cmp al, byte[len]
    jae exit_check_space
    mov cl, byte[string + eax]
    cmp cl, 32
    je increment
    inc byte[i]
    jmp check_space_loop

        increment:
        inc byte[counter]
        inc byte[i]
        jmp check_space_loop

exit_check_space:
mov cx, 0
mov cl, byte[counter]
mov word[num], cx
call print_num
popa
ret

print_num:
pusha
mov word[count], 0

extract_digit:
mov ax, word[num]
cmp ax, 0
je print_num_loop

inc word[count]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_digit

print_num_loop:
mov ax, word[count]
cmp ax, 0
je exit_print_num

dec word[count]
pop dx
mov word[temp], dx
add word[temp], 30h

mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 0x80

jmp print_num_loop

exit_print_num:
mov eax, 4
mov ebx, 1
mov ecx, nwl
mov edx, 1
int 0x80

popa
ret