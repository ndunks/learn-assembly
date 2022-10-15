CC := mips-linux-gnu-gcc
ASFLAGS := -v -Wall -mips32 -EB -march=4kc
LDFLAGS := -Wl,--build-id=none -static -nostdlib -O0 -s -mno-abicalls -fno-pic


mips32 : LDFLAGS+= -nostartfiles -T mips32-linker.ld

# while inotifywait -e close_write -qq Makefile *.S; make -B linux32; done
# while inotifywait -e close_write -qq Makefile *.S; do sleep 0.3; qemu-mips linux32; done
# while inotifywait -e close_write -qq Makefile *.S; do sleep 0.3; mips-linux-gnu-objdump -D linux32; done
