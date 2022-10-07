#!/bin/bash
# nodemon -w qemulate.sh --delay 100ms -I -x './qemulate.sh || false'

set -e
err_report() {
    sudo umount ./disk/loop || true
    echo "Error on line $1"
}

trap 'err_report $LINENO' ERR

mkdir -p tmp
[ -f tmp/busybox ] \
    || wget -O tmp/busybox https://busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-mips \
    && chmod +x tmp/busybox

mkdir -p disk
mount | grep $PWD/disk || sudo mount -t tmpfs tmpfs ./disk
mount | grep $PWD/disk/loop && sudo umount ./disk/loop

mkdir -p disk/loop
dd if=/dev/zero of=disk/disk.img bs=1024 count=5000
mkfs.ext2 -F disk/disk.img

cat <<EOF | sudo bash
set -e
echo "Creating rootfs.."
mount -t ext2 -o loop disk/disk.img ./disk/loop

mkdir -p disk/loop/{bin,dev,proc,sys}

mknod disk/loop/dev/console c 5 1

cp a.out disk/loop/app
cp tmp/busybox disk/loop/

ln -s /busybox disk/loop/bin/sh

cat > disk/loop/init <<END
#!/bin/sh
export PATH=/bin
/busybox --install -s /bin
mount -t proc none /proc
mount -t sysfs none /sys
mount -t tmpfs none /dev
mdev -s
exec /bin/getty -n -l /bin/sh ttyS0 115200 vt100
END
chmod +x disk/loop/init
sync
sudo umount ./disk/loop
EOF
echo "Starting qemu.."

qemu-system-mips -M malta \
    -nographic -serial mon:stdio \
    -kernel vmlinux-2.6.32-5-4kc-malta \
    -drive file=disk/disk.img,format=raw \
    -append "root=/dev/sda rw init=/init console=ttyS0" \
