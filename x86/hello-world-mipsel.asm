global _start
; Using linux syscall
; printf SYS_write | mips-linux-gnu-gcc -include sys/syscall.h -E -
; printf SYS_exit | mips-linux-gnu-gcc -include sys/syscall.h -E -

section .data
_start:
    li $v0, 4 ; Kernel syscall call
    la $a0, msg ; 
    int 0x80 ; write(stdout, str, str_len)

    li $v0, 0 ; Kernel syscall call
    int 0x80

section .data
    msg: .asciiz `Hello world\n`
    msglen: equ $ - msg

; Emulating
