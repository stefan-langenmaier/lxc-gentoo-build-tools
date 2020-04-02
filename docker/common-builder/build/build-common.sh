#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=common-builder-builder-instance
INAME=slangenmaier/common-builder
ROOTFS=/mnt/full-data/vols/common-builder/common-builder/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} ln -s -f ../../usr/portage/profiles/default/linux/arm/17.0/armv7a /etc/portage/make.profile'

# the builder will need the build deps also installed
docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ $BNAME bash -c "emerge -uD --with-bdeps=y --root-deps @system @world"
docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ $BNAME bash -c "emerge -u sys-devel/make"
set -e

create_image

stop_container
