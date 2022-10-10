#include <unistd.h>
#include <sys/syscall.h>

// mips-linux-gnu-gcc -fno-plt -fno-pic -o hello hello.c
// mips-linux-gnu-objdump -d hello > hello.S

int main() {
    const char hell[] = "Hello world\n";
    syscall(SYS_write, 1, &hell, sizeof(hell));
    syscall(SYS_exit, 1);
}