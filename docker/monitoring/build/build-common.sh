#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=monitoring-builder-instance
INAME=slangenmaier/monitoring
ROOTFS=/mnt/full-data/vols/common-builder/monitoring/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add prometheus default'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add alertmanager default'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add collectd default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd alertmanager'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd collectd'
set -e

create_image

stop_container
