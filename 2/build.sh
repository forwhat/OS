#!/bin/bash
dd if=/dev/zero of=os.img bs=512 count=4

nasm boot.asm -o boot.bin
nasm ball.asm -o ball.bin
nasm showstr.asm -o showstr.bin
nasm roll.asm -o roll.bin

dd if=boot.bin of=os.img bs=512 count=1 conv=notrunc
dd if=ball.bin of=os.img bs=512 count=1 seek=1 conv=notrunc
dd if=showstr.bin of=os.img bs=512 count=1 seek=2 conv=notrunc
dd if=roll.bin of=os.img bs=512 count=1 seek=3 conv=notrunc
