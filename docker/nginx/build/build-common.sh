#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=nginx-builder-instance
INAME=slangenmaier/nginx
ROOTFS=/mnt/full-data/vols/common-builder/nginx/

start_builder_container

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'groupadd --system --gid 999 nginx'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'useradd --system -d /var/lib/nginx/ -s /sbin/nologin --uid 999 --gid 999 nginx'
set -e

install_base_system

set +e
docker exec -e ROOT=/build/rootfs -e PORTAGE_CONFIGROOT=/build/portage-configroot $BNAME bash -c 'emerge -1 dev-python/cffi dev-python/cryptography'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add nginx default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 999 nginx'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -d /var/lib/nginx/ -s /sbin/nologin --uid 999 --gid 999 nginx'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd nginx'
set -e

create_image

stop_container
