#!/bin/bash

CONTAINER_NAME=cubox-i

mount /mnt/full-root/ #|| die "Failed mounting full root"
mount -o subvol=vols/${CONTAINER_NAME} /dev/mmcblk0p3 /var/lib/lxc/${CONTAINER_NAME}


# install world
lxc-start -n ${CONTAINER_NAME}
lxc-attach -n ${CONTAINER_NAME} -- /bin/bash
lxc-stop -n ${CONTAINER_NAME}
