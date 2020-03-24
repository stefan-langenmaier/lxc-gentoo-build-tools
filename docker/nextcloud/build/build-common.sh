#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=nextcloud-builder-instance
INAME=slangenmaier/nextcloud
ROOTFS=/mnt/full-data/vols/common-builder/nextcloud/

start_builder_container

install_base_system

set +e
docker cp container-specific-setup.sh $BNAME:/build/rootfs/
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} bash /container-specific-setup.sh'
set -e

create_image

stop_container
