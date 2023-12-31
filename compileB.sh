#!/bin/bash

#put together by Joshua Sheputa

# creates diskc.img
dd if=/dev/zero of=diskc.img bs=512 count=1000

#copies bootload to first sector of diskc.img
dd if=bootload of=diskc.img bs=512 count=1 conv=notrunc

#assembles kernel.asm
as86 kernel.asm -o kernel_asm.o

#assembles kernel.c
bcc -ansi -c -o kernel_c.o kernel.c

#link the kernels
ld86 -o kernel -d kernel_c.o kernel_asm.o

#copy machin code kernel ont diskc.img sector 3
dd if=kernel of=diskc.img bs=512 conv=notrunc seek=3

#copy message.txt in secotr 30
#dd if=message.txt of=diskc.img bs=512 count=1 seek=30 conv=notrunc
