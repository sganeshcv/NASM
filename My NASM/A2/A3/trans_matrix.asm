section .data
    tab: db 9
    nwl: db 10

    msg_rows: db "Enter the now of rows in the matrix : ",
    msg_rows_size:  equ $-msg_rows

    msg_cols: db "Enter the now of cols in the matrix : ",
    msg_cols_size:  equ $-msg_cols

    msg_ele: db "Enter the elements one by one : "
    msg_ele_size: equ $-msg_ele

    msg_matrix1: db "First matrix : ",10
    msg_matrix1_size: equ $-msg_matrix1

    msg_matrix2: db "Second matrix : ",10
    msg_matrix2_size: equ $-msg_matrix2

    msg_matrix3: db "Final matrix : ",10
    msg_matrix3_size: equ $-msg_matrix3

section .bss
    i : resw 1
    j : resw 1
    k : resw 1
    num : resw 10
    m : resw 10
    n : resw 10
    matrix : resw 200
    matrix1 : resw 200
    matrix2 : resw 200

    m1 : resw 200
    m2 : resw 200
    temp : resw 10
    count : resw 1

section .text   
    global _start:
_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_rows
    mov edx, msg_rows_size
    int 0x80

    call read_num
    mov cx, word[num]
    mov word[m], cx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_cols
    mov edx, msg_cols_size
    int 0x80

    call read_num
    mov cx, word[num]
    mov word[n], cx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_ele
    mov edx, msg_ele_size
    int 0x80  

    call read_matrix1

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_matrix1
    mov edx, msg_matrix1_size
    int 0x80 

    call print_matrix1

    ; mov eax, 4
    ; mov ebx, 1
    ; mov ecx, msg_matrix2
    ; mov edx, msg_matrix2_size   
    ; int 0x80 

    ; call print_matrix2

    call trans_matrix

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_matrix3
    mov edx, msg_matrix3_size
    int 0x80 

    call print_matrix

    ;EXIT
    mov eax, 1
    mov ebx, 0
    int 0x80


read_num:
    pusha
    mov word[num], 0
    loop_read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    cmp byte[temp], 10
    je end_read
    mov ax, word[num]   
    mov bl, 10
    mul bl
    mov bx, word[temp]
    sub bx, 30h
    add ax, bx
    mov word[num], ax
    jmp loop_read
end_read:
popa
ret

read_matrix1:
    pusha
    mov word[i], 0
    mov word[k], 0
    i_loop:
    mov ax, word[i]
    cmp ax, word[m]
    jae end_i_loop
    mov word[j], 0
        j_loop:
        mov ax, word[j]
        cmp ax, word[n]
        jae end_j_loop
        call read_num
        mov cx, word[num]
        movzx eax, word[k]
        mov word[matrix1 + 2*eax], cx
        inc word[k]
        inc word[j]
        jmp j_loop

        end_j_loop:
        inc word[i]
        jmp i_loop
    
    end_i_loop:
    popa
    ret

read_matrix2:
    pusha
    mov word[i], 0
    mov word[k], 0
    i_loop2:
    mov ax, word[i]
    cmp ax, word[m]
    jae end_i_loop2
    mov word[j], 0
        j_loop2:
        mov ax, word[j]
        cmp ax, word[n]
        jae end_j_loop2
        call read_num
        mov cx, word[num]
        movzx eax, word[k]
        mov word[matrix2 + 2*eax], cx
        inc word[k]
        inc word[j]
        jmp j_loop2

        end_j_loop2:
        inc word[i]
        jmp i_loop2
    
    end_i_loop2:
    popa
    ret


print_num:
    mov byte[count], 0
    pusha
    extract_no:
    cmp word[num], 0
    je print_no
    inc byte[count]
    mov dx, 0
    mov ax, word[num]
    mov bx, 10
    div bx
    push dx
    mov word[num], ax
    jmp extract_no
    print_no:
    cmp byte[count], 0
    je end_print
    dec byte[count]
    pop dx
    mov byte[temp], dl
    add byte[temp], 30h
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    jmp print_no
    end_print:
    mov eax, 4
    mov ebx, 1
    mov ecx, tab
    mov edx, 1
    int 0x80
    popa    
    ret


print_matrix:
    pusha
    mov word[i], 0
    mov word[k], 0
    i1_loop:
    mov ax, word[i]
    cmp ax, word[n]
    jae end_i1_loop
    mov word[j], 0
        j1_loop:
        mov ax, word[j]
        cmp ax, word[m]
        jae end_j1_loop
        movzx eax, word[k]
        mov cx, word[matrix + 2*eax]
        mov word[num], cx
        call print_num
        inc word[k]
        inc word[j]
        jmp j1_loop

        end_j1_loop:
        mov eax, 4
        mov ebx, 1
        mov ecx, nwl
        mov edx, 1
        int 0x80
        inc word[i]
        jmp i1_loop
    
    end_i1_loop:
    popa
    ret

print_matrix1:
    pusha
    mov word[i], 0
    mov word[k], 0
    i4_loop:
    mov ax, word[i]
    cmp ax, word[m]
    jae end_i4_loop
    mov word[j], 0
        j4_loop:
        mov ax, word[j]
        cmp ax, word[n]
        jae end_j4_loop
        movzx eax, word[k]
        mov cx, word[matrix1 + 2*eax]
        mov word[num], cx
        call print_num
        inc word[k]
        inc word[j]
        jmp j4_loop

        end_j4_loop:
        mov eax, 4
        mov ebx, 1
        mov ecx, nwl
        mov edx, 1
        int 0x80
        inc word[i]
        jmp i4_loop
    
    end_i4_loop:
    popa
    ret

print_matrix2:
    pusha
    mov word[i], 0
    mov word[k], 0
    i5_loop:
    mov ax, word[i]
    cmp ax, word[m]
    jae end_i5_loop
    mov word[j], 0
        j5_loop:
        mov ax, word[j]
        cmp ax, word[n]
        jae end_j5_loop
        movzx eax, word[k]
        mov cx, word[matrix2 + 2*eax]
        mov word[num], cx
        call print_num
        inc word[k]
        inc word[j]
        jmp j5_loop

        end_j5_loop:
        mov eax, 4
        mov ebx, 1
        mov ecx, nwl
        mov edx, 1
        int 0x80
        inc word[i]
        jmp i5_loop
    
    end_i5_loop:
    popa
    ret


trans_matrix:
    pusha
    mov word[i], 0
    mov word[k], 0
    i3_loop:
    mov ax, word[i]
    cmp ax, word[m]
    jae end_i3_loop
    mov word[j], 0
        j3_loop:
        mov ax, word[j]
        cmp ax, word[n]
        jae end_j3_loop
        movzx eax, word[k]
        mov cx, word[matrix1 + 2*eax]
        mov word[temp], cx
        mov ax, word[n]
        mov bx, word[j]
        mul bx
        mov bx, word[i]
        add ax, bx
        movzx ebx, ax
        mov dx, word[temp]
        mov word[matrix + 2*ebx], dx 
        inc word[k]
        inc word[j]
        jmp j3_loop

        end_j3_loop:
        inc word[i]
        jmp i3_loop

    end_i3_loop:
    popa
    ret
