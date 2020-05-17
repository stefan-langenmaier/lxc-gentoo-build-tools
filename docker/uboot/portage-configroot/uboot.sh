#!/bin/bash
set -e
set -x

ROOTFS="/build/rootfs"

if [ ! -d "${ROOTFS}/root/u-boot" ]
then
	mkdir -p ${ROOTFS}/root
	cd ${ROOTFS}/root
	git clone "https://github.com/u-boot/u-boot"
fi
cd ${ROOTFS}/root/u-boot
git checkout v2018.09
make mx6cuboxi_defconfig
make

#cp /root/u-boot/SPL /autodeploy-exchange/SPL
#cp /root/u-boot/u-boot.img /autodeploy-exchange/u-boot.img

