#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=elasticsearch-builder-instance
INAME=slangenmaier/elasticsearch
ROOTFS=/mnt/full-data/vols/common-builder/elasticsearch/

start_builder_container

#docker exec -e ROOTFS=/build/rootfs -it $BNAME bash
docker exec $BNAME bash -c 'emerge -u dev-util/gperf'

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} bash -c "mkdir -p  /dev ; touch /dev/null "'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} eselect java-vm set system 1'
set -e
install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add elasticsearch default'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 183 elasticsearch'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -d /usr/share/elasticsearch -s /sbin/nologin --uid 183 --gid 183 elasticsearch'
set -e

create_image

stop_container
