# MIPS Linux using Assembly


- Kernel 2.6.x
- ucLibc https://uclibc.org/downloads/uClibc-0.9.33.tar.xz

## Compile Hello World
```
make hello --nos
```
Example init script
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