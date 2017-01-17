#!/bin/bash

CONTAINER_NAME=gentoo-base-container

mountpoint -q /mnt/full-root/ || mount /mnt/full-root/ #|| die "Failed mounting full root"
mountpoint -q /var/lib/lxc/${CONTAINER_NAME} || mount -o subvol=vols/${CONTAINER_NAME} /dev/mmcblk0p3 /var/lib/lxc/${CONTAINER_NAME}

# copy configs from template
[[ -d template/${CONTAINER_NAME} ]] && cp -a template/${CONTAINER_NAME}/* /var/lib/lxc/${CONTAINER_NAME}

# install world
lxc-start -n ${CONTAINER_NAME}
if [[ "$1" == "interactive" ]] ; then
	lxc-attach -n ${CONTAINER_NAME}
else
	lxc-attach -n ${CONTAINER_NAME} -- eselect news read
	lxc-attach -n ${CONTAINER_NAME} -- emerge -uDN world --with-bdeps=y
	lxc-attach -n ${CONTAINER_NAME} -- etc-update -p # do trivial merges
fi
lxc-stop -n ${CONTAINER_NAME}
