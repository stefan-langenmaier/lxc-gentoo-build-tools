#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=jdk-builder-instance
INAME=slangenmaier/jdk-slim
ROOTFS=/mnt/full-data/vols/common-builder/jdk/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} update-ca-certificates'
set -e

create_image

stop_container
