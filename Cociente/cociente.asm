; Programa: Cociente de dos enteros con entrada del usuario
; Ensamblar: nasm -f elf32 cociente.asm -o cociente.o
; Enlazar:   ld -m elf_i386 cociente.o -o cociente

section .data
    msg1 db "Ingrese el numerador: ", 0
    msg2 db "Ingrese el denominador: ", 0
    msg_result db "El cociente es: ", 0
    msg_error db "¡Error! No se puede dividir entre cero.", 10
    msg_error_len equ $ - msg_error
    newline db 10

section .bss
    input1 resb 4
    input2 resb 4
    output resb 8

section .text
    global _start

_start:
    ; Mensaje 1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 24
    int 0x80

    ; Leer input1
    mov eax, 3
    mov ebx, 0
    mov ecx, input1
    mov edx, 4
    int 0x80

    ; Mensaje 2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 26
    int 0x80

    ; Leer input2
    mov eax, 3
    mov ebx, 0
    mov ecx, input2
    mov edx, 4
    int 0x80

    ; Convertir input1 (numerador)
    mov ecx, input1
    call ascii_to_int
    mov esi, eax       ; numerador → ESI

    ; Convertir input2 (denominador)
    mov ecx, input2
    call ascii_to_int
    mov edi, eax       ; denominador → EDI

    ; Verificar si denominador es 0
    cmp edi, 0
    je division_cero

    ; División: ESI / EDI
    mov eax, esi
    xor edx, edx
    div edi            ; EAX = ESI / EDI

    ; Convertir EAX a ASCII en output
    mov ebx, 10
    mov edi, output + 7
    mov byte [edi], 0
    dec edi

.print_digit:
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz .print_digit
    inc edi

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, 17
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, 8
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    jmp salir

division_cero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_error
    mov edx, msg_error_len
    int 0x80

salir:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ----------------------
ascii_to_int:
    xor eax, eax
    xor ebx, ebx
.next_char:
    mov bl, byte [ecx]
    cmp bl, 10
    je .done
    cmp bl, 13
    je .done
    cmp bl, 0
    je .done
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc ecx
    jmp .next_char
.done:
    ret
