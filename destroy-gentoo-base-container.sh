#!/bin/bash

set -ux

CONTAINER_NAME=gentoo-base-container
#CONTAINER_NAME=cubox-i

lxc-stop -n ${CONTAINER_NAME} || echo "not running"
# NOT needed #lxc-destroy -n ${CONTAINER_NAME}

mountpoint -q /var/lib/lxc/${CONTAINER_NAME}
if [ $? -eq 0 ]; then
	umount /var/lib/lxc/${CONTAINER_NAME}
	rmdir /var/lib/lxc/${CONTAINER_NAME}
fi
mountpoint -q /mnt/full-root/ || mount /mnt/full-root
btrfs sub delete /mnt/full-root/vols/${CONTAINER_NAME}/rootfs
btrfs sub delete /mnt/full-root/vols/${CONTAINER_NAME}
