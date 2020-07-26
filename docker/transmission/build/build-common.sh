#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=transmission-builder-instance
INAME=slangenmaier/transmission
ROOTFS=/mnt/full-data/vols/common-builder/transmission/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add transmission-daemon default'

#docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 169 transmission'
#docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /var/lib/transmission --uid 169 --gid 169 transmission'
set -e

create_image

stop_container
