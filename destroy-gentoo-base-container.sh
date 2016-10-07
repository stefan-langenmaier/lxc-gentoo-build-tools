#!/bin/bash

#CONTAINER_NAME=gentoo-base-container
CONTAINER_NAME=owncloud-app

lxc-stop -n ${CONTAINER_NAME}
# NOT needed #lxc-destroy -n ${CONTAINER_NAME}
umount /var/lib/lxc/${CONTAINER_NAME}
rmdir /var/lib/lxc/${CONTAINER_NAME}
btrfs sub delete /mnt/full-root/vols/${CONTAINER_NAME}
