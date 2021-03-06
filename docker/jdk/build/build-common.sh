#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=jdk-builder-instance
INAME=slangenmaier/jdk
ROOTFS=/mnt/full-data/vols/common-builder/jdk/

start_builder_container

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} mkdir /dev'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} touch /dev/null'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} update-ca-certificates'
# no gentoo vm installed
#docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} eselect java-vm set system 1'
set -e

install_base_system

create_image

stop_container
