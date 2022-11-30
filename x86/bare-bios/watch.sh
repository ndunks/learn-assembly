#!/bin/sh
set -e

while true; do
    echo "Compiling.."
    as -o hello-world-16.o hello-world-16.S && \
        ld -Ttext 0x7c00 --oformat=binary -o hello-world-16 hello-world-16.o && \
        objdump -d -mi386 -Maddr16,data16 --adjust-vma=0x7c00 hello-world-16.o && \
        dd conv=notrunc if=hello-world-16 of=disk.img || \
        echo "Failed"
    echo "Waiting changes.."
    inotifywait -e close_write -q *.S
    sleep 0.2
done
