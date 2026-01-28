all:
	mkdir -p out
	aarch64-linux-gnu-as -o out/tcpSocket.o src/tcpSocket.s
	aarch64-linux-gnu-ld -o out/tcpSocket out/tcpSocket.o
	qemu-aarch64 -L /usr/aarch64-linux-gnu out/tcpSocket
	
build:
	mkdir -p out
	aarch64-linux-gnu-as -o out/tcpSocket.o src/tcpSocket.s
	aarch64-linux-gnu-ld -o out/tcpSocket out/tcpSocket.o
	
run:
	qemu-aarch64 -L /usr/aarch64-linux-gnu out/tcpSocket
