global _start

; Using linux syscall,
; $ printf SYS_write | gcc -include sys/syscall.h -E -
section .text
_start:

mov eax, 4 ; Kernel syscall call
mov ebx, 1 ; STDOUT
mov ecx, str ; 
mov edx, str_len
int 0x80 ; write(stdout, str, str_len)

; exit(0)
mov eax, 1
mov ebx, 0
int 0x80

section .data
str: db "Hello World", 10
str_len: equ $ - str

; compile to object:
;   nasm -f elf32 hello-world-linux-32.asm
; make linux binary:
;   ld -m elf_i386 -o hello-world-linux-32.out hello-world-linux-32.o
; run it:
;   ./hello-world-linux-32.out