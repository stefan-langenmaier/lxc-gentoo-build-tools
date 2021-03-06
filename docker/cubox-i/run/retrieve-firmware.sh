#!/bin/bash

mkdir /lib/firmware/vpu -p
mkdir /lib/firmware/imx/sdma -p
mkdir /lib/firmware/brcm -p
mkdir /lib/firmware/ti-connectivity -p

if [ ! -e "/lib/firmware/vpu/vpu_fw_imx6q.bin" ]
then
	wget http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.0.bin
	dd if=firmware-imx-8.0.bin bs=37180 skip=1 | tar xj
	mv firmware-imx-8.0/firmware/vpu/vpu_fw_imx6q.bin /lib/firmware/vpu/
	mv firmware-imx-8.0/firmware/sdma/sdma-imx6q.bin /lib/firmware/imx/sdma/
fi

if [ ! -e "/lib/firmware/imx/sdma/sdma-imx6q.bin" ]
then
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/imx/sdma/sdma-imx6q.bin
	cp sdma-imx6q.bin /lib/firmware/imx/sdma/sdma-imx6q.bin
fi

if [ ! -e "/lib/firmware/brcm/brcmfmac4330-sdio.bin" ]
then
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/brcm/brcmfmac4330-sdio.bin
	mv brcmfmac4330-sdio.bin /lib/firmware/brcm/brcmfmac4330-sdio.bin
fi
if [ ! -e "/lib/firmware/brcm/brcmfmac4330-sdio.txt" ]
then
	wget https://github.com/Freescale/meta-freescale-3rdparty/raw/master/recipes-bsp/broadcom-nvram-config/files/cubox-i/brcmfmac4330-sdio.txt
	mv brcmfmac4330-sdio.txt /lib/firmware/brcm/brcmfmac4330-sdio.txt
fi

if [ ! -e "/lib/firmware/brcm/brcmfmac4329-sdio.bin" ]
then
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/brcm/brcmfmac4329-sdio.bin
	mv brcmfmac4329-sdio.bin /lib/firmware/brcm/brcmfmac4329-sdio.bin
fi
if [ ! -e "/lib/firmware/brcm/brcmfmac4329-sdio.txt" ]
then
	wget https://github.com/Freescale/meta-freescale-3rdparty/raw/master/recipes-bsp/broadcom-nvram-config/files/cubox-i/brcmfmac4329-sdio.txt
	mv brcmfmac4329-sdio.txt /lib/firmware/brcm/brcmfmac4329-sdio.txt
fi

if [ ! -e "/lib/firmware/ti-connectivity/TIInit_11.8.32.bts" ]
then
	wget https://github.com/TI-ECS/bt-firmware/raw/master/TIInit_11.8.32.bts
	mv TIInit_11.8.32.bts /lib/firmware/ti-connectivity/TIInit_11.8.32.bts
fi

if [ ! -e "/lib/firmware/ti-connectivity/wl1271-nvs.bin" ]
then
	wget https://github.com/TI-OpenLink/firmwares/raw/master/ti-connectivity/wl1271-nvs.bin
	mv wl1271-nvs.bin /lib/firmware/ti-connectivity/wl1271-nvs.bin
fi
