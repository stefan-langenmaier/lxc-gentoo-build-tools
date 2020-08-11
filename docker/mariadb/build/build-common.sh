#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=mariadb-builder-instance
INAME=slangenmaier/mariadb
ROOTFS=/mnt/full-data/vols/common-builder/mariadb/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add mysql default'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 60 mysql'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -d /var/lib/mysql/ -s /sbin/nologin --uid 60 --gid 60 mysql'
set -e

create_image

stop_container
