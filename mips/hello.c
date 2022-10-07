#include <unistd.h>
#include <sys/syscall.h>

// mips-linux-gnu-gcc -static  hello.c

int main() {
    const char hell[] = "Hello world\n";
    syscall(SYS_write, 1, &hell, sizeof(hell));
    syscall(SYS_exit, 1);
}