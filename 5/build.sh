#!/bin/bash

dd if=/dev/zero of=os5.0.img bs=512 count=20

nasm boot.asm -o boot.bin
dd if=boot.bin of=os5.0.img bs=512 count=1 conv=notrunc

nasm -f elf kernel.asm -o kernel.o
gcc -ffreestanding -c ckernel.c -o ckernel.o
ld -s kernel.o ckernel.o -o kernel.bin -Ttext 0x0 --oformat binary
dd if=kernel.bin of=os5.0.img bs=512 count=10 seek=1 conv=notrunc

nasm -f elf upper.asm -o upper.o
gcc -ffreestanding -c cupper.c -o cupper.o
ld -s upper.o cupper.o -o upper.bin -Ttext 0x0 --oformat binary
dd if=upper.bin of=os5.0.img bs=512 count=2 seek=11 conv=notrunc

nasm ball.asm -o ball.bin
dd if=ball.bin of=os5.0.img bs=512 count=2 seek=13 conv=notrunc

nasm -f elf testsysInt.asm -o test.o
gcc -ffreestanding -c ctest.c -o ctest.o
ld -s test.o ctest.o -o test.bin -Ttext 0x0 --oformat binary
dd if=test.bin of=os5.0.img bs=512 count=3 seek=15 conv=notrunc

ndisasm -b 16 ctest.o > tmp
rm *.bin *.o
ndisasm -b 16 os5.0.img > debug
