#!/bin/bash
set -e
set -x

if [ ! -d "/root/u-boot" ]
then
	cd /root
	git clone "https://github.com/u-boot/u-boot"
#else
#	git fetch
fi
cd /root/u-boot
git checkout v2018.09
make mx6cuboxi_defconfig
make