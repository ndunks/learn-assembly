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

### Err Qemu

- https://lists.nongnu.org/archive/html/qemu-devel/2011-07/msg00133.html
- https://github.com/nfd/ci20-hello-world
- https://github.com/zephyrproject-rtos/zephyr/tree/v3.0.0/soc/mips/qemu_malta

```
IN: 
0xbfc00000:  li v0,11
0xbfc00004:  li a0,65
0xbfc00008:  syscall

OP:
 ld_i32 tmp0,env,$0xfffffffffffffff0
 brcond_i32 tmp0,$0x0,lt,$L0

 ---- bfc00000 00000000 00000000
 mov_i32 v0,$0xb

 ---- bfc00004 00000000 00000000
 mov_i32 a0,$0x41

 ---- bfc00008 00000000 00000000
 mov_i32 PC,$0xbfc00008
 call raise_exception_err,$0x8,$0,env,$0x11,$0x0
 set_label $L0
 exit_tb $0x7f1ec0000043

do_raise_exception_err: 17 (syscall) 0
mips_cpu_do_interrupt enter: PC bfc00008 EPC 00000000 syscall exception
mips_cpu_do_interrupt: PC bfc00380 EPC bfc00008 cause 8
    S 00400006 C 00000420 A 00000000 D 00000000
----------------

```