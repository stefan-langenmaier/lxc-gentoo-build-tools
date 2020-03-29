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
docker exec $BNAME bash -c 'emerge -u dev-libs/libfmt dev-libs/spdlog dev-libs/pugixml'
docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ -e EGIT_COMMIT="4aa895993baf2e91f72265ac81004cfd2f0e50eb" $BNAME bash -c 'emerge -u gerbera'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add gerbera default'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 429 gerbera'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -d /var/lib/gerbera/ -s /sbin/nologin --uid 429 --gid 429 gerbera'
set -e

create_image

stop_container
