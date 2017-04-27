#!/bin/bash

set -eux

CONTAINER_NAME=gentoo-base-container

mountpoint -q /mnt/full-root/ || mount /mnt/full-root/
btrfs sub create /mnt/full-root/vols/${CONTAINER_NAME}
btrfs sub create /mnt/full-root/vols/${CONTAINER_NAME}/rootfs
mkdir -p /var/lib/lxc/${CONTAINER_NAME}
mount -o subvol=vols/${CONTAINER_NAME} /dev/mmcblk1p3 /var/lib/lxc/${CONTAINER_NAME}
lxc-create -t gentoo -n ${CONTAINER_NAME} -- --arch arm --variant armv7a_hardfp
