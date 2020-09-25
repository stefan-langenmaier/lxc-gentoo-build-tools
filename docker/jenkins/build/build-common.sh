#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=jenkins-builder-instance
INAME=slangenmaier/jenkins
ROOTFS=/mnt/full-data/vols/common-builder/jenkins/
CONTAINER_MOUNT=yes

start_builder_container

install_base_system

set +e
#docker exec -e ROOTFS=/build/rootfs -e PORTAGE_CONFIGROOT=/build/portage-configroot $BNAME bash -c 'emerge libltdl -1 -av'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} mkdir -p /dev'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} touch /dev/null'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} eselect java-vm set system 1'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add jenkins default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd -g 246 jenkins'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --uid 999 --gid 246 -d /var/lib/jenkins jenkins'
# totally NOT portable
# to specify here what the mapped docker file will have as a groupid
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd -g 120 outerdocker'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} usermod  -a -G 120 jenkins'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} chown jenkins:jenkins /home/jenkins -R'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} update-ca-certificates'
set -e

create_image

stop_container
