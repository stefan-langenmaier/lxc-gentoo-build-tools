#!/bin/bash
set -e
set -x

cd /root
mkdir /lib/firmware/imx/sdma -p

if [ ! -e "/lib/firmware/vpu_fw_imx6q.bin" ]
then
	wget http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-7.9.bin
	dd if=firmware-imx-7.9.bin bs=38868 skip=1 | tar xj
	cp firmware-imx-7.9/firmware/vpu/vpu_fw_imx6q.bin /lib/firmware
fi

if [ ! -e "/lib/firmware/imx/sdma/sdma-imx6q.bin" ]
then
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/imx/sdma/sdma-imx6q.bin
	cp sdma-imx6q.bin /lib/firmware/imx/sdma/sdma-imx6q.bin
fi

emerge -u gentoo-sources
emerge --depclean
eselect kernel set 1
cp /kernel-config /usr/src/linux/.config
cd /usr/src/linux
make oldconfig
make -j5
make dtbs

cp /usr/src/linux/arch/arm/boot/zImage /autodeploy-exchange/zImage
cp /usr/src/linux/arch/arm/boot/dts/imx6q-cubox-i.dtb /autodeploy-exchange/imx6q-cubox-i.dtb

