#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=kibana-builder-instance
INAME=slangenmaier/kibana
ROOTFS=/mnt/full-data/vols/common-builder/kibana/

start_builder_container

docker exec -e ROOTFS=/build/rootfs -it $BNAME bash

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add kibana default'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 269 kibana'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -d /var/lib/kibana -s /sbin/nologin --uid 269 --gid 269 kibana'
set -e

create_image

stop_container
