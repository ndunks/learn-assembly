
##define v0      $2      /* return value */
##define v1      $3
##define a0      $4      /* argument registers */
##define a1      $5
##define a2      $6
##define a3      $7

# Using Linux Kernel
# printf SYS_write | mips-linux-gnu-gcc -include sys/syscall.h -E -
# printf SYS_exit | mips-linux-gnu-gcc -include sys/syscall.h -E -

#include <sys/regdef.h>

.global _start
#.set noat
.data
msg:
    .ascii "Hello world\n\x0"
    msglen: $ - msg
.text
_start:
    # li $4, v0       # write (
    # li $1, a0       #   stdout,
    # la a1, $msg     #   &msg,
    # lw a2, msglen  #   length,
    # syscall        # )
    li $2,     $2    # write (
    li $4,     $4   #   stdout,
    la msg,   $5   #   &msg,
    lw msglen,$6   #   length,
    syscall        # )

    # li 29, v0 # pause
    # syscall
    # # syscall for exit
    # li zero, v0
    # syscall

# Compiling
# mips-linux-gnu-as -march=4kc -mtun=4kc -mno-shared hello-world-linux-32.S
# Emulating
