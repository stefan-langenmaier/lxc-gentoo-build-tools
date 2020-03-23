#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=nginx-builder-instance
INAME=slangenmaier/nginx-slim
ROOTFS=/mnt/full-data/vols/common-builder/nginx/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add nginx default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd nginx'
set -e

create_image

stop_container
