all: linux32

linux32:
	@mips-linux-gnu-as -EB -non_shared -march=4kc -o hello-world-linux-32.o hello-world-linux-32.S
	@mips-linux-gnu-ld -o hello-world-linux-32.elf hello-world-linux-32.o
	@mips-linux-gnu-objdump -d hello-world-linux-32.elf
	@qemu-mips -cpu 4Kc hello-world-linux-32.elf

.PHONY: all linux32