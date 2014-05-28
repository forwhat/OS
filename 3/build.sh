#!/bin/bash

dd if=/dev/zero of=os3.0.img bs=512 count=13

nasm boot.asm -o boot.bin
dd if=boot.bin of=os3.0.img bs=512 count=1 conv=notrunc

nasm -f elf kernel.asm -o kernel.o
gcc -ffreestanding -c ckernel.c -o ckernel.o
ld -s kernel.o ckernel.o -o kernel.bin -Ttext 0x0 --oformat binary
dd if=kernel.bin of=os3.0.img bs=512 count=10 seek=1 conv=notrunc

nasm -f elf upper.asm -o upper.o
gcc -ffreestanding -c cupper.c -o cupper.o
ld -s upper.o cupper.o -o upper.bin -Ttext 0x0 --oformat binary
dd if=upper.bin of=os3.0.img bs=512 count=2 seek=11 conv=notrunc

rm *.bin *.o
ndisasm -b 16 os3.0.img > debug
