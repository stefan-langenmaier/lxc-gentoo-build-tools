#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=gerbera-builder-instance
INAME=slangenmaier/gerbera
ROOTFS=/mnt/full-data/vols/common-builder/gerbera/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add gerbera default'
set -e

create_image

stop_container
