#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=uboot-builder-instance
INAME=slangenmaier/uboot
ROOTFS=/mnt/full-data/vols/common-builder/uboot

start_builder_container

#install_base_system

set +e
# chroot or not to chroot
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'bash /build/portage-configroot/uboot.sh'

# hobo transfer
docker container create --name transfer-container -v autodeploy-exchange:/autodeploy-exchange slangenmaier/nothing
docker cp uboot-builder-instance:/build/rootfs/root/u-boot/SPL - | docker cp - transfer-container:/autodeploy-exchange/
docker cp uboot-builder-instance:/build/rootfs/root/u-boot/u-boot.img - | docker cp - transfer-container:/autodeploy-exchange/
docker container rm transfer-container

set -e

#create_image

stop_container
