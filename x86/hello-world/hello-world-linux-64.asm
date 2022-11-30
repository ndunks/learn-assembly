global _start

; Using linux syscall,
; $ printf SYS_write | gcc -include sys/syscall.h -E -
section .text
_start:
  mov rax, 1        ; write(
  mov rdi, 1        ;   STDOUT_FILENO,
  mov rsi, msg      ;   "Hello, world!\n",
  mov rdx, msglen   ;   sizeof("Hello, world!\n")
  syscall           ; );

  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );

section .data
  msg: db "Hello, world!", 10
  msglen: equ $ - msg

; compile to object:
;   nasm -f elf64 hello-world-linux-64.asm
; make linux binary:
;   ld -m elf_x86_64 -o hello-world-linux-64.out hello-world-linux-64.o
; run it:
;   ./hello-world-linux-64.out
; one liner:
; nasm -f elf64 hello-world-linux-64.asm && ld -m elf_x86_64 -o hello-world-linux-64.out
