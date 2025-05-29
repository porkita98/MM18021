; Programa: Resta de tres enteros (16 bits) con entrada del usuario
; Ensamblar: nasm -f elf32 resta.asm -o resta.o
; Enlazar:   ld -m elf_i386 resta.o -o resta

bits 32

section .data
  msg1    db "Ingrese el primer numero: ", 0
  len1    equ $ - msg1
  msg2    db "Ingrese el segundo numero: ", 0
  len2    equ $ - msg2
  msg3    db "Ingrese el tercer numero: ", 0
  len3    equ $ - msg3

  prefix  db "Result: ",0
  buf     db "00000",10   ; espacio para 5 dígitos + '\n'

section .bss
  input   resb 6
  num1    resw 1
  num2    resw 1
  num3    resw 1
  result  resw 1

section .text
  global _start

_start:
  ; Leer primer número
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, len1
  int 0x80

  mov eax, 3
  mov ebx, 0
  mov ecx, input
  mov edx, 6
  int 0x80

  mov esi, input
  call ascii_to_int
  mov [num1], cx

  ; Leer segundo número
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, len2
  int 0x80

  mov eax, 3
  mov ebx, 0
  mov ecx, input
  mov edx, 6
  int 0x80

  mov esi, input
  call ascii_to_int
  mov [num2], cx

  ; Leer tercer número
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, len3
  int 0x80

  mov eax, 3
  mov ebx, 0
  mov ecx, input
  mov edx, 6
  int 0x80

  mov esi, input
  call ascii_to_int
  mov [num3], cx

  ; Resta en 16 bits
  mov  ax, [num1]
  mov  bx, [num2]
  sub  ax, bx
  mov  cx, [num3]
  sub  ax, cx
  mov  [result], ax

  ; Imprimir "Result: "
  mov  eax,4
  mov  ebx,1
  mov  ecx,prefix
  mov  edx,8
  int 0x80

  ; Convertir [result] a ASCII decimal, 5 dígitos
  movsx eax, word [result]  ; extensión con signo
  lea   edi, [buf+4]        ; puntero al último dígito
  mov   ecx, 5
.conv:
  xor   edx,edx
  mov   ebx,10
  div   ebx
  add   dl,'0'
  mov   [edi], dl
  dec   edi
  dec   ecx
  test  eax,eax
  jnz   .conv
.pad:
  cmp   ecx,0
  je    .donepad
  mov   byte [edi],'0'
  dec   edi
  dec   ecx
  jmp   .pad
.donepad:

  ; Imprimir buf
  mov  eax,4
  mov  ebx,1
  mov  ecx,buf
  mov  edx,6
  int 0x80

  ; Salir
  mov  eax,1
  xor  ebx,ebx
  int 0x80

; ----------------------------------------
; Función: convierte texto ASCII en ESI → número en CX
ascii_to_int:
  xor cx, cx
  xor bx, bx
.next_digit:
  mov bl, byte [esi]
  cmp bl, 10
  je .done
  cmp bl, 13
  je .done
  cmp bl, 0
  je .done
  sub bl, '0'
  imul cx, cx, 10
  add cx, bx
  inc esi
  jmp .next_digit
.done:
  ret

