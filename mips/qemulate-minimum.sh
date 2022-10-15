#!/bin/bash
# nodemon -w qemulate.sh --delay 100ms -I -x './qemulate.sh || false'

set -e

# Use ram instead disk while building fs image
mkdir -p disk
mount | grep $PWD/disk || sudo mount -t tmpfs tmpfs ./disk
mount | grep $PWD/disk/loop && sudo umount ./disk/loop

mkdir -p disk/loop
dd if=/dev/zero of=disk/disk.img bs=1024 count=1024
mkfs.ext2 -F disk/disk.img

cat <<EOF | sudo bash
set -e
echo "Creating rootfs.."
mount -t ext2 -o loop disk/disk.img ./disk/loop

cp linux32 disk/loop/
chmod +x disk/loop/linux32
sync
sudo umount ./disk/loop
EOF
echo "Starting qemu.."

qemu-system-mips -M malta \
    -nodefaults \
    -nographic -serial mon:stdio \
    -kernel vmlinux \
    -drive file=disk/disk.img,format=raw \
    -append "root=/dev/sda rw rootfstype=ext2 init=/linux32 console=ttyS0" \
