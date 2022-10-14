all: linux32
# nodemon --delay 100ms --signal SIGKILL -w Makefile -w *.ld -w *.asm -x 'make mips32 || false'
mips32Linux:
	mips-linux-gnu-as -EB -O0 -non_shared -march=4kc -o hello-world-32.o hello-world-32.asm
	mips-linux-gnu-ld -e 0 -O0  --oformat elf32-tradbigmips \
	-o hello-world-32.elf hello-world-32.o
#	-T hello-world-32.ld
	mips-linux-gnu-objdump -m mips -d hello-world-32.elf

mips32:

	mips-linux-gnu-as -EB -O0 -non_shared -march=4kc -o hello-world-32.o hello-world-32.asm

	mips-linux-gnu-ld -O0 --oformat binary \
	-T hello-world-32.ld \
	-o hello-world-32.bin hello-world-32.o

#	qemu-mips hello-world-32.bin
#	Convert RAW binary to ELF
# mips-linux-gnu-objcopy -I binary -O elf32-tradbigmips -B mips \
# --rename-section .data=.text --change-address 0xbfc00000 hello-world-32.bin \
# hello-world-32.bin.elf

# mips-linux-gnu-objdump -m mips -d hello-world-32.bin.elf

#	qemu-system-mips -M malta -cpu 4Kc \
#    -nodefaults \
#	-no-reboot -no-shutdown \
#	-bios ./hello-world-32.bin \
#	-d in_asm 2>&1 | head -n 50
	qemu-system-mips -M malta -cpu 4Kc \
    -serial mon:stdio \
    -nodefaults \
	-no-reboot -no-shutdown \
	-bios hello-world-32.bin \
	-d unimp,in_asm,int,op 2>&1 | head -n 40
#	-drive if=pflash,file=hello-world-32.bin,format=raw \
#	-kernel hello-world-32.bin \

#	qemu-mips -cpu 4Kc hello-world-32.bin
#	-d in_asm \

linux32:
	@mips-linux-gnu-as -EB -non_shared -march=4kc -o hello-world-linux-32.o hello-world-linux-32.S
	@mips-linux-gnu-ld -o hello-world-linux-32.elf hello-world-linux-32.o
	@mips-linux-gnu-objdump -d hello-world-linux-32.elf
	@qemu-mips -cpu 4Kc hello-world-linux-32.elf

.PHONY: all linux32 mips32