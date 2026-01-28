# TCP Socket In ARM64

This project is a TCP Socket written in the ARM64 assembly programming language.

## Background

Since I'm working on an x86 machine, I can't natively compile & execute on an ARM64 instruction set. 

To bridge this gap, I use [Qemu](https://www.qemu.org/]), a generic opensource emulator. 

Rather than emulating an entire ARM system which would be computationally expensive for just a TCP Socket; QEMU allows us to achieve user-mode emulation by utilizing the qemu-aarch64 package, a Linux CPU emulator.

qemu-aarch64 translates syscalls & machine code in a ARM64 executable to machine code understood by the host CPU. With this approach I get full access to POSIX syscalls (networking, file I/O, memory management) without the overhead of kernel-level or hardware virtualization.

This setup provides an efficient development workflow for learning low-level systems programming with the ARM64 instruction set.

## Project Requirements

- A TCP Socket written in ARM64 assembly shall respond to a basic HTTP Get Request with HTML Content.

- TCP Socket shall be packaged for the WSL Almalinux, SUSE, & Ubuntu operating systems

- TCP Socket shall be packaged in a Container

## Available Resources

- [ARM Syscalls](https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/unistd.h)
- [ARM64 Procedure Call Standard - Chapter Six](https://student.cs.uwaterloo.ca/~cs452/docs/rpi4b/aapcs64.pdf)
- [Qemu Build Wiki](https://wiki.qemu.org/Hosts/Linux)
- [Qemu Build System Architecture](https://www.qemu.org/docs/master/devel/build-system.html#stage-1-configure)
- [How to Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
## Almalinux Quickstart
- [Qemu Gitlab](https://gitlab.com/qemu-project/qemu)

> Since Fedora only offers Qemu's KVM Virtualization software in their RPM
> Repositories, we'll need to compile Qemu from source to compile against ARM64.

1. Begin by ensuring your core development tools are up to date. <br>
    ```bash
    dnf groupinstall "Development Tools" 
    ```
2. Install the tools need to build aarch64-qemu
    ```bash 
        dnf install git glib2-devel libfdt-devel pixman-devel zlib-devel bzip2 ninja-build python3 python3-tomli  
    ```
3. Install the cross compilers 
    ```bash
        sudo dnf install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu -y
    ```
4. Clone the repository && create a build directory
    ```bash
        git clone https://gitlab.com/qemu-project/qemu.git &&\
        cd qemu &&\
        mkdir build &&\
        cd build
    ```
5. Run Qemu's configuration script
    ```bash
        ../configure --target-list=aarch64-linux-user
    ```
6. Once configuration is complete, compile the executable
    ```bash
        # -j$(nproc) will multiprocess compilation on all present CPU cores. Remove this argument if that is not your desired behavior.
        make -j$(nproc)
    ```
7. Install the executable (requires sudo privileges)
    ``` bash
        sudo make install
    ```
8. Verify aarch64 is installed
    ```bash
        qemu-aarch64 --version
    ```

9. Compile and run the TCP Socket
    ```bash
        # Assemble
        aarch64-linux-gnu-as -o tcpSocket.o tcpSocket.s
        # Link
        aarch64-linux-gnu-ld -o tcpSocket tcpSocket.o
        # Run with QEMU
        qemu-aarch64 -L /usr/aarch64-linux-gnu tcpSocket
    ```
<i>If this message is still displayed, all source code, ci-cd, & documentation in this repository are hand written by a human.</i> 
