# MIPS Linux using Assembly

- Kernel 2.6.x
- ucLibc https://uclibc.org/downloads/uClibc-0.9.33.tar.xz

## Compile kernel



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

## Compile and run MIPS Qemu Hello World

**C version:**

``` bash

mips-linux-gnu-gcc -static  hello.c
./qemulate

```

## Referrences
- https://irix7.com/techpubs.html
- https://www.dsi.unive.it/~gasparetto/materials/MIPS_Instruction_Set.pdf
- http://winfred-lu.blogspot.com/2010/06/step-by-step-to-mips-assembly.html