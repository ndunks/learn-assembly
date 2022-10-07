#include <unistd.h>
#include <sys/syscall.h>

// mips-linux-gnu-gcc -static -fno-stack-protector --enable-kernel hello.c
// gcc  -static -fno-stack-protector -z execstack hello.c
int main() {
    const char hell[] = "Hello world\n";
    syscall(SYS_write, 1, &hell, sizeof(hell));
    syscall(SYS_pause);
}