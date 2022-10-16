CC := mips-linux-gnu-gcc
ASFLAGS := -Wall -mips32 -EB -march=4kc
LDFLAGS := -Wl,--build-id=none -static -nostdlib -O0 -s -mno-abicalls -fno-pic

mips32 : LDFLAGS+= -nostartfiles -T mips32-linker.ld -s

watch_mips32:
	while true; do \
		make start_mips32 & \
		echo "started pid $$!" ;\
		inotifywait -e close_write -q Makefile *.S ;\
		kill -9 $$(pidof qemu-system-mips) || true ;\
		make -B mips32 || echo "**FAILED**" ;\
		sleep 0.5 ;\
	done

start_mips32:
	qemu-system-mips -M malta -nodefaults -serial mon:stdio -kernel mips32

start_mips32_debug:
	qemu-system-mips -M malta -nodefaults -serial mon:stdio -kernel mips32 \
	-s -d in_asm,guest_errors,int 2>&1 | head -n 100

.PHONY: watch_% start_mips32 start_mips32_debug