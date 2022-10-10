# Example helloworld Using Syscall from Linux Kernel

# printf SYS_write | mips-linux-gnu-gcc -include sys/syscall.h -E -
# (4000 + 4)
# printf SYS_exit | mips-linux-gnu-gcc -include sys/syscall.h -E -
# (4000 + 29)
# file:///usr/mips-linux-gnu/include/asm/unistd_o32.h

# Compiling:
# mips-linux-gnu-as -EB -non_shared -march=4kc -o hello-world-linux-32.o hello-world-linux-32.S
# mips-linux-gnu-ld -o hello-world-linux-32.elf hello-world-linux-32.o
# mips-linux-gnu-objdump -d hello-world-linux-32.elf

# Emulating:
# qemu-mips -cpu 4Kc hello-world-linux-32.elf

.data
msg: .asciiz "Hello World\n"
.align 4

.text
.globl __start
__start:

    li      $v0,    4000+4      # write (
    li      $a0,    1           # stdout,
    la      $a1,    msg         # &msg,
    li      $a2,    12          # length,
    syscall                     # )

    li      $v0,    4000+29     # pause (
    syscall                     # );
