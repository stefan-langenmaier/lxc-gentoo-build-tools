#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=cubox-i-builder-instance
INAME=slangenmaier/cubox-i
ROOTFS=/mnt/full-data/vols/common-builder/cubox-i/
# to have the bdeps also installed
SYSROOT=/build/rootfs

start_builder_container

# workaround docker
#docker exec $BNAME bash -c 'emerge -uDN dev-go/go-md2man'
# workaround mailutils
#docker exec $BNAME bash -c 'emerge -uDN sys-apps/tcp-wrappers'
# workaround iftop
#docker exec $BNAME bash -c 'emerge -uDN net-libs/libpcap'
# workaround lvm2
#docker exec $BNAME bash -c 'emerge -uDN dev-libs/libaio virtual/libudev'

#docker exec -it $BNAME bash

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} ln -s -f ../../usr/portage/profiles/default/linux/arm/17.0/armv7a /etc/portage/make.profile'

docker exec -e ROOTFS=/build/rootfs $BNAME bash /build/portage-configroot/container-specific-setup.sh
docker exec -it -e ROOTFS=/build/rootfs $BNAME bash
set -e

create_image

stop_container
