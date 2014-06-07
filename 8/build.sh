#!/bin/bash

dd if=/dev/zero of=os8.0.img bs=512 count=35

nasm boot.asm -o boot.bin
dd if=boot.bin of=os8.0.img bs=512 count=1 conv=notrunc

nasm -f elf kernel.asm -o kernel.o
gcc -ffreestanding -c ckernel.c -o ckernel.o -nostdlib
ld -s kernel.o ckernel.o -o kernel.bin -Ttext 0x0 --oformat binary
dd if=kernel.bin of=os8.0.img bs=512 count=20 seek=1 conv=notrunc

nasm -f elf test.asm -o test.o
gcc -ffreestanding -c ctest.c -o ctest.o -nostdlib
ld -s test.o ctest.o -o test.bin -Ttext 0x0 --oformat binary
dd if=test.bin of=os8.0.img bs=512 count=4 seek=21 conv=notrunc

nasm -f elf test2.asm -o test2.o
gcc -ffreestanding -c ctest2.c -o ctest2.o -nostdlib
ld -s test2.o ctest2.o -o test2.bin -Ttext 0x0 --oformat binary
dd if=test2.bin of=os8.0.img bs=512 count=4 seek=25 conv=notrunc

rm *.bin *.o
