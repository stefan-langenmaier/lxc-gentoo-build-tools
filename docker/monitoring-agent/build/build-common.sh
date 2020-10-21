#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=monitoring-agent-builder-instance
INAME=slangenmaier/monitoring-agent
ROOTFS=/mnt/full-data/vols/common-builder/monitoring-agent/

start_builder_container

install_base_system

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add collectd default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd collectd'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} usermod -a -G disk collectd'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} mkdir -p /var/log/'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} touch /var/log/collectd.log'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} chown collectd:collectd /var/log/collectd.log'
set -e

create_image

stop_container
