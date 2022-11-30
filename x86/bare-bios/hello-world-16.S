# Refs:
#   https://github.com/Stefan20162016/linux-insides-code/blob/master/bootloader.asm
#   https://en.wikipedia.org/wiki/BIOS_interrupt_call#Interrupt_table
#   https://www.codeproject.com/Articles/664165/Writing-a-boot-loader-in-Assembly-and-C-Part
#   https://sourceware.org/binutils/docs/as/Pseudo-Ops.html

# Compiles:
# as -o hello-world-16.o hello-world-16.S
# ld -Ttext 0x7c00 --oformat=binary -o hello-world-16 hello-world-16.o

# Make Floppy disk
# dd if=/dev/zero of=disk.img bs=512 count=2880
# dd conv=notrunc if=hello-world-16 of=disk.img

# Run it
# qemu-system-x86_64 -d in_asm disk.img

.code16                   # 16-bit code rather than 32-bit
.text
.globl _start
_start:
    mov $hello, %si
    mov $0xe, %ah
print_hello:
    lodsb # Load byte to %al from DS:(E)SI
    and %al, %al
    jz  sleep
    int $0x10
    jmp print_hello
sleep:
    mov $0x8600, %ax               # function 0x86 - wait
    mov $0x002d, %cx               # put time in microseconds to cx:dx
    xor %dx, %dx                   # use zero here to minify code
    int $0x15
    ret 

hello: .asciz "Hello World"

. = _start + 446 # Padding fill with 0 until 446
# Partition table here

. = _start + 510 # Padding fill with 0 until 510
.byte   0x55, 0xAA   # Tell BIOS that this disk has MBR bootloader
