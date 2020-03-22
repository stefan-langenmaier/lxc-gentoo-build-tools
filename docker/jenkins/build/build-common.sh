#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=jenkins-builder-instance
INAME=slangenmaier/jenkins
ROOTFS=/mnt/full-data/vols/common-builder/jenkins/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add jenkins default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd jenkins'
# totally NOT portable
# to specify here what the mapped docker file will have as a groupid
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd -g 120 outerdocker'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} usermod  -a -G 120 jenkins'
set -e

create_image

stop_container
