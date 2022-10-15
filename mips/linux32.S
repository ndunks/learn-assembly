# Example hello world MIPS 32bit BigEndian Using Syscall from Linux Kernel

# Compiling:
# make linux32

# Emulating Qemu Static:
# qemu-mips -cpu 4Kc linux32

# Emulating Qemu System:
# ./qemulate-minimum.sh

# printf SYS_write | mips-linux-gnu-gcc -include sys/syscall.h -E -
# (4000 + 4)
# printf SYS_exit | mips-linux-gnu-gcc -include sys/syscall.h -E -
# (4000 + 29)


# Registers
# file:///usr/mips-linux-gnu/include/sys/regdef.h
# include <regdef.h>

# Linux Syscalls
# file:///usr/mips-linux-gnu/include/asm/unistd_o32.h
# include <asm/unistd.h>

.data
.align 2
msg: .asciiz "Hello World\n"
msglen: .word . - msg

.text
.set	noreorder
.globl __start
__start:
    lui     gp, 0x42                # How to get this value from gcc?
    addiu   gp, gp,         _gp
    li      v0, __NR_write          # write (
    li      a0, 1                   # stdout,
    la      a1, msg                 # &msg,
    lw      a2, msglen              # length,
    syscall                         # )

    li      v0, __NR_exit           # exit (
    move    a0, zero                # 0,
    syscall                         # );
