#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=nextcloud-builder-instance
INAME=slangenmaier/nextcloud
ROOTFS=/mnt/full-data/vols/common-builder/nextcloud/

start_builder_container

install_base_system

set +e
docker exec $BNAME bash -c 'emerge -uDN app-admin/webapp-config app-eselect/eselect-php'
#docker exec -e ROOT=/build/rootfs -e PORTAGE_CONFIGROOT=/build/portage-configroot $BNAME bash -c 'emerge -uDN --onlydeps nextcloud'
#docker exec $BNAME bash -c 'emerge --nodeps -u nextcloud'
docker cp container-specific-setup.sh $BNAME:/
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'bash /container-specific-setup.sh'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 12 mail'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /var/spool/mail --uid 8 --gid 12 mail'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /var/spool/mail --uid 14 --gid 12 postmaster'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 16 cron'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /var/spool/cron --uid 16 --gid 16 cron'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 60 mysql'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /dev/null --uid 60 --gid 60 mysql'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 75 redis'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /dev/null --uid 75 --gid 75 redis'

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} groupadd --system --gid 245 nginx'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd --system -s /sbin/nologin -d /var/lib/nginx --uid 999 --gid 245 nginx'
set -e

create_image

stop_container
