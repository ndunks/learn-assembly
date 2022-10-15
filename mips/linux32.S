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
# include <sys/asm.h>

# Refference on docs or here https://refspecs.linuxfoundation.org/elf/mipsabi.pdf
# Symbols
# _end:
# correspond to the beginning of the dynamic allocation area of a program,
# called the heap. Typically, the heap begins immediately after the data
# segment of the program executable file.

# _gp:
# This symbol is defined by the link editor and provides the value used for
# the gp register for this executable or shared object file

# _gp_disp:
# represents the offset between the beginning of the function and
# the global offset table

# use LDFLAGS:  -mno-abicalls -fno-pic
# to make variable address not depend on gp (got)

.data
.align 2
msg: .asciiz "Hello World\n"
.align		4
msglen: .word . - msg

.text
.globl __start
__start:
    li      v0, __NR_write          # write (
    li      a0, 1                   # stdout,
    la      a1, msg                 # &msg,
    lw      a2, msglen              # length,
    syscall                         # )

    li      v0, __NR_exit           # exit (
    move    a0, zero                # 0,
    syscall                         # );
