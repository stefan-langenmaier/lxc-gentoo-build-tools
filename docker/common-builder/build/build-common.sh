#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=common-builder-builder-instance
INAME=slangenmaier/common-builder
ROOTFS=/mnt/full-data/vols/common-builder/common-builder/
# to have the bdeps also installed
SYSROOT=/build/rootfs
RUNTIME=full

start_builder_container

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'eselect binutils set 1'

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} ln -s -f ../../usr/portage/profiles/default/linux/arm/17.0/armv7a /etc/portage/make.profile'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} mkdir -p /etc/portage/repos.conf'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} mkdir -p /dev'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} touch /dev/null'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} eselect binutils set 1'

docker cp gentoo.conf $BNAME:/build/rootfs/etc/portage/repos.conf/gentoo.conf
set -e

create_image

stop_container
