#!/bin/bash

set -eux

CONTAINER_NAME=cubox-i
BASE_CONTAINER_NAME=gentoo-base-container

mountpoint -q /mnt/full-root/ || mount /mnt/full-root/
btrfs sub snap /mnt/full-root/vols/${BASE_CONTAINER_NAME} /mnt/full-root/vols/${CONTAINER_NAME}
rmdir /mnt/full-root/vols/${CONTAINER_NAME}/rootfs
btrfs sub snap /mnt/full-root/vols/${BASE_CONTAINER_NAME}/rootfs /mnt/full-root/vols/${CONTAINER_NAME}/rootfs
mkdir -p /var/lib/lxc/${CONTAINER_NAME}
mount -o subvol=vols/${CONTAINER_NAME} /dev/mmcblk1p3 /var/lib/lxc/${CONTAINER_NAME}
mount -o subvol=vols/${CONTAINER_NAME}/rootfs /dev/mmcblk1p3 /var/lib/lxc/${CONTAINER_NAME}/rootfs

# copy configs from template
[[ -d template/${CONTAINER_NAME} ]] && cp -a template/${CONTAINER_NAME}/* /var/lib/lxc/${CONTAINER_NAME}

# uninstall ssh
chroot "/var/lib/lxc/${CONTAINER_NAME}/rootfs" rc-update del sshd

# install world
lxc-start -n ${CONTAINER_NAME}
lxc-attach -n ${CONTAINER_NAME} -- eselect news read
lxc-attach -n ${CONTAINER_NAME} -- emerge -uDN world --with-bdeps=y
lxc-attach -n ${CONTAINER_NAME} -- etc-update -p # do trivial merges
#lxc-attach -n ${CONTAINER_NAME} -- etc-update --automode -9 # ignore the rest
lxc-attach -n ${CONTAINER_NAME} -- bash /container-specific-setup.sh
lxc-stop -n ${CONTAINER_NAME}

