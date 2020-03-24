#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=kodi-builder-instance
INAME=slangenmaier/kodi
ROOTFS=/mnt/full-data/vols/common-builder/kodi/

start_builder_container

install_base_system

set +e
docker cp container-specific-setup.sh $BNAME:/build/rootfs/
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} bash /container-specific-setup.sh'
docker cp dw-hdmi-ahb-aud.conf $BNAME:/build/rootfs/usr/share/alsa/cards/
set -e

create_image

stop_container
