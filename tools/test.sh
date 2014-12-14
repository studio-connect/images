#!/bin/bash
qemu="/opt/qemu-2.1.2/arm-softmmu/qemu-system-arm"
export QEMU_AUDIO_DRV=none
$qemu -daemonize -nographic -M vexpress-a9 -kernel zImage \
	-drive file=root.img,if=sd,cache=none -append "root=/dev/mmcblk0p2 rw" \
	-m 512 -net nic -net user,hostfwd=tcp::2222-:22 -snapshot
sleep 20
ssh  -o StrictHostKeyChecking=no root@127.0.0.1 -p2222 "curl -L https://raw.githubusercontent.com/studio-link/images/master/bootstrap.sh | bash -x"
