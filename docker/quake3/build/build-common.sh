#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=quake3-builder-instance
INAME=slangenmaier/quake3
ROOTFS=/mnt/full-data/vols/common-builder/quake3/

start_builder_container

install_base_system

set +e
# groupadd --system --gid 35 games
#  usermod -a -G games quake3
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 35 games'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 666 quake3'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -d /var/lib/quake3/ -s /sbin/nologin --uid 666 --gid 666 quake3'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} usermod -a -G games quake3'
set -e

create_image

stop_container
