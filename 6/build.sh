#!/bin/bash

dd if=/dev/zero of=os6.0.img bs=512 count=35

nasm boot.asm -o boot.bin
dd if=boot.bin of=os6.0.img bs=512 count=1 conv=notrunc

nasm -f elf kernel.asm -o kernel.o
gcc -ffreestanding -c ckernel.c -o ckernel.o -nostdlib
ld -s kernel.o ckernel.o -o kernel.bin -Ttext 0x0 --oformat binary
dd if=kernel.bin of=os6.0.img bs=512 count=20 seek=1 conv=notrunc

nasm p1.asm -o p1.bin
dd if=p1.bin of=os6.0.img bs=512 count=2 seek=21 conv=notrunc

nasm p2.asm -o p2.bin
dd if=p2.bin of=os6.0.img bs=512 count=2 seek=23 conv=notrunc

nasm p3.asm -o p3.bin
dd if=p3.bin of=os6.0.img bs=512 count=2 seek=25 conv=notrunc

nasm p4.asm -o p4.bin
dd if=p4.bin of=os6.0.img bs=512 count=2 seek=27 conv=notrunc

nasm -f elf testsysInt.asm -o test.o
gcc -ffreestanding -c ctest.c -o ctest.o -nostdlib
ld -s test.o ctest.o -o test.bin -Ttext 0x0 --oformat binary
dd if=test.bin of=os6.0.img bs=512 count=3 seek=29 conv=notrunc
rm *.bin *.o
