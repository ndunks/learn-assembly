# MIPS Linux using Assembly

## MIPS Qemu Hello World with Linux Kernel

``` bash
# Compile
make linux32
# Run with Qemu user static (using your OS kernel)
qemu-mips -cpu 4Kc linux32

# Run with Qemu system emulator (using prebuilt kernel)
./qemulate-minimum.sh

```

## MIPS Qemu Hello World Baremetal

``` bash
# Compiling
make mips32

# Running with Qemu
make start_mips32

# Running with Qemu with assembler displayed
make start_mips32_debug

```

## Compile kernel

- Kernel 2.6.x
- ucLibc https://uclibc.org/downloads/uClibc-0.9.33.tar.xz

use .config from vmlinux.config for mips an no networking support, just for test

``` bash
cd tmp
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.19.14.tar.xz
tar -xvf linux-5.19.14.tar.xz
cp ../vmlinux.config linux-5.19.14/.config
make -C ./linux-5.19.14 ARCH=mips CROSSCOMPILE=mips-linux-gnu- -j3 vmlinux
```
**Example init script:**

``` bash
#!/bin/sh
export PATH=/bin
/busybox --install -s /bin
ln -s /busybox /bin/

echo "Init \\\$(tty) \\\$(env)"

busybox mount -t proc none /proc
busybox mount -t sysfs none /sys
busybox mount -t tmpfs none /dev
mdev -s

exec /bin/getty -n -l /bin/sh ttyS0 115200 vt100
```

## Referrences
- https://refspecs.linuxfoundation.org/elf/mipsabi.pdf
- https://www.dsi.unive.it/~gasparetto/materials/MIPS_Instruction_Set.pdf
- http://winfred-lu.blogspot.com/2010/06/step-by-step-to-mips-assembly.html
