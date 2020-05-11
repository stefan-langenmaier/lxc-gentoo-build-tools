#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=kernel-builder-instance
INAME=slangenmaier/kernel
ROOTFS=/mnt/full-data/vols/common-builder/kernel

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'eselect kernel set 1'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'cp /build/portage-configroot/kernel-config ${ROOTFS}/usr/src/linux/.config'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'cd ${ROOTFS}/usr/src/linux ; make oldconfig ; make -j5 ; make dtbs'

#cp /usr/src/linux/arch/arm/boot/zImage /autodeploy-exchange/zImage
#cp /usr/src/linux/arch/arm/boot/dts/imx6q-cubox-i.dtb /autodeploy-exchange/imx6q-cubox-i.dtb
#cp /usr/src/linux/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb /autodeploy-exchange/imx6q-cubox-i-emmc-som-v15.dtb
#cp /usr/src/linux/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb /autodeploy-exchange/imx6q-cubox-i-som-v15.dtb

set -e

#create_image

stop_container
