# Example hello world MIPS 32bit BigEndian WITHOUT Linux Kernel
# Using Qemu Malta - Yamon API to show text
# https://www.dsi.unive.it/~gasparetto/materials/MIPS_Instruction_Set.pdf
# https://github.com/tilkinsc/MipsBareBones
# https://github.com/qemu/qemu/blob/master/hw/mips/

# Compiling:
# make mips32

# Emulating Qemu:
# make start_mips32

# Registers
# file:///usr/mips-linux-gnu/include/sys/regdef.h

#include <regdef.h>

.data
msg: .asciiz "\nHello World <- Printed from Qemu\n"

.text
.globl start
start:
    # Yamom API Service vector for print null terminated string
    # https://github.com/qemu/qemu/blob/2ba341b3694cf3cff7b8a1df4cc765900d5c4f60/hw/mips/malta.c#L956
    li t0, 0x1fc00808
    li a0, 0
    la a1, msg
    jalr t0
    nop
    
	# Show text on Malta ASCII FPGA IO Memory
    # https://github.com/tilkinsc/MipsBareBones/blob/master/WriteOutASCII/main.s
    xor t0, t0
    xor t1, t1
	li t0, 0x1F000418
    li t1, 'H'
    sw t1, 0(t0)
    li t1, 'E'
    sw t1, 8(t0)
    li t1, 'L'
    sw t1, 16(t0)
    li t1, 'L'
    sw t1, 24(t0)
    li t1, 'O'
    sw t1, 32(t0)
    li t1, '.'
    sw t1, 40(t0)
    li t1, '.'
    sw t1, 48(t0)
    li t1, '!'
    sw t1, 56(t0)
    wait
