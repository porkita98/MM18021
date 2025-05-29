# Repositorio de Programas en Lenguaje Ensamblador

Este repositorio contiene tres programas en lenguaje ensamblador, desarrollados como parte del curso **Diseño y Estructura de Computadoras**. Cada programa realiza una operación aritmética básica utilizando diferentes registros y técnicas.

---

## 📁 Contenido del Repositorio

### 🧮 Ejercicio 1: Resta de Tres Enteros
- **Archivo:** `resta.asm`
- **Descripción:**
  - Realiza la resta de tres números enteros ingresados por el usuario usando registros de 16 bits.
  - Muestra el resultado en pantalla con un mensaje descriptivo.
- **Técnicas utilizadas:**
  - Operaciones con registros `AX`, `BX`, `CX`.
  - Conversión de números a ASCII.
  - Llamadas al sistema para impresión en consola.
- **Compilación y ejecución:**
  ```bash
nasm -f elf32 resta.asm -o resta.o
ld -m elf_i386 resta.o -o resta
.resta


### 🧮 Ejercicio 2: Producto de dos Enteros
- **Archivo:** `producto.asm`
- **Descripción:**
Multiplica dos números usando registros AL y BL.

Convierte el resultado a ASCII y lo muestra en pantalla.

Características:

Manejo de buffers para conversión numérica.

Optimización para números pequeños.

Compilación y ejecución:

bash
; Programa: Producto de dos enteros con entrada del usuario
; Ensamblar: nasm -f elf32 producto.asm -o producto.o
; Enlazar:   ld -m elf_i386 producto.o -o producto

### 🧮 Ejercicio 3: Cociente de dos Enteros
- **Archivo:** `cociente.asm`
- **Descripción:**
Divide dos números enteros de 32 bits

Muestra el cociente y maneja el caso de división por cero con un mensaje de advertencia.

Aspectos destacables:

Uso de registros EAX, EDX, EDI.

Instrucción DIV para 32 bits.

Validación previa del denominador.

Compilación y ejecución:

bash
; Programa: Cociente de dos enteros con entrada del usuario
; Ensamblar: nasm -f elf32 cociente.asm -o cociente.o
; Enlazar:   ld -m elf_i386 cociente.o -o cociente




💻 Requisitos del Sistema
Sistema operativo Linux

NASM (Netwide Assembler) instalado

Enlazador ld

Arquitectura x86 (32 bits)

📂 Estructura de Directorios
.
├── Resta/
│   ├── resta.asm
├── Producto/
│   ├── multiplicacion.asm
└── Cociente/
    ├── division.asm

🤝 Contribuciones
Este repositorio es parte de un ejercicio académico. Las contribuciones son bienvenidas para:

Mejorar los mensajes de salida.

Agregar manejo de errores más robusto.

Implementar versiones optimizadas o variantes en 64 bits.