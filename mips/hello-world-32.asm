# Example hello world MIPS 32bit BigEndian WITHOUT Linux Kernel
# https://www.dsi.unive.it/~gasparetto/materials/MIPS_Instruction_Set.pdf
# https://irix7.com/techpubs.html

# Compiling:
# make mips32

# Emulating Qemu Static:
# qemu-mips -cpu 4Kc hello-world-32.bin

# Emulating Qemu System:

.data
msg: .asciiz "\n\n\n\n\nHello World\n"

.text
.set noreorder
.set mips32
.set noat
.globl start
.ent start
start:

    li      $v0,    11      # print_char(
    li      $a0,    65      # char,
    syscall 
    li      $v0,    11      # print_char(
    li      $a0,    65      # char,
    syscall                 # )
    # j       start
    # nop     
    li      $v0,    4       # print_string(
    la      $a0,    msg     # &msg,
    syscall                 # )
    li      $v0,    12
    syscall 
    li      $v0,    10      # exit(
    syscall                 # );
    nop     
    nop     
    nop     
.end start
