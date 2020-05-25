#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=autodeploy-builder-instance
INAME=slangenmaier/autodeploy
ROOTFS=/mnt/full-data/vols/common-builder/autodeploy/

# additional permissions to dynamically mount directories
CONTAINER_MOUNT=yes

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME /bin/bash /build/portage-configroot/prepare-script.sh

# hobo transfer
docker container create --name transfer-container -v autodeploy-exchange:/autodeploy-exchange slangenmaier/nothing
docker cp transfer-container:/autodeploy-exchange/SPL - | docker cp - autodeploy-builder-instance:/build/rootfs/root/cubox-i-autodeploy-image/u-boot-bin/
docker cp transfer-container:/autodeploy-exchange/u-boot.img - | docker cp - autodeploy-builder-instance:/build/rootfs/root/cubox-i-autodeploy-image/u-boot-bin/
docker cp transfer-container:/autodeploy-exchange/zImage - | docker cp - autodeploy-builder-instance:/build/rootfs/root/cubox-i-autodeploy-image/kernel-bin/
docker cp transfer-container:/autodeploy-exchange/imx6q-cubox-i.dtb - | docker cp - autodeploy-builder-instance:/build/rootfs/root/cubox-i-autodeploy-image/kernel-bin/
docker cp transfer-container:/autodeploy-exchange/imx6q-cubox-i-emmc-som-v15.dtb - | docker cp - autodeploy-builder-instance:/build/rootfs/root/cubox-i-autodeploy-image/kernel-bin/
docker cp transfer-container:/autodeploy-exchange/imx6q-cubox-i-som-v15.dtb - | docker cp - autodeploy-builder-instance:/build/rootfs/root/cubox-i-autodeploy-image/kernel-bin/
docker container rm transfer-container

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c "cp /build/portage-configroot/build-image.sh /build/rootfs/"
docker exec -e ROOTFS=/build/rootfs $BNAME chroot /build/rootfs /bin/bash /build-image.sh
set -e

#create_image

stop_container
