#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=backup-builder-instance
INAME=slangenmaier/backup
ROOTFS=/mnt/full-data/vols/common-builder/backup/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add cronie default'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add dbus default'
set -e

create_image

stop_container
