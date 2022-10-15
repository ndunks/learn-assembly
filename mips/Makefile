CC := mips-linux-gnu-gcc
ASFLAGS := -mips32 -EB -march=4kc -fno-plt -fno-pic -O0 -fpie -s
LDFLAGS := -static -nostdlib

mips32 : LDFLAGS+= -nostartfiles -T mips32-linker.ld
