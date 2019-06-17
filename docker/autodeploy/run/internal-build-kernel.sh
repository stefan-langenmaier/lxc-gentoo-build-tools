#!/bin/bash
set -e
set -x

cd /root

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
cp /usr/src/linux/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb /autodeploy-exchange/imx6q-cubox-i-emmc-som-v15.dtb
cp /usr/src/linux/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb /autodeploy-exchange/imx6q-cubox-i-som-v15.dtb

