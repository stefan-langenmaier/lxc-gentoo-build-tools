#!/bin/bash

CONTAINER_NAME=gentoo-base-container

mount /mnt/full-root/ #|| die "Failed mounting full root"
btrfs sub create /mnt/full-root/vols/${CONTAINER_NAME}
mkdir -p /var/lib/lxc/${CONTAINER_NAME}
mount -o subvol=vols/${CONTAINER_NAME} /dev/mmcblk0p3 /var/lib/lxc/${CONTAINER_NAME}
lxc-create -t gentoo -n ${CONTAINER_NAME} -- --arch arm --variant armv7a_hardfp
#lxc-create -t gentoo -n ${CONTAINER_NAME} -- --autologin --arch arm --variant armv7a_hardfp
