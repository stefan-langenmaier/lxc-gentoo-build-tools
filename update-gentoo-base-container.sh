#!/bin/bash

set -eux

CONTAINER_NAME=$1
#CONTAINER_NAME=gentoo-base-container
#CONTAINER_NAME=cubox-i

mountpoint -q /mnt/full-root/ || mount /mnt/full-root/ #|| die "Failed mounting full root"
mkdir -p /var/lib/lxc/${CONTAINER_NAME}
mountpoint -q /var/lib/lxc/${CONTAINER_NAME} || mount -o subvol=vols/${CONTAINER_NAME} /dev/mmcblk1p3 /var/lib/lxc/${CONTAINER_NAME}

# install world
lxc-start -n ${CONTAINER_NAME}
if [[ $# -gt 1 &&  "$2" == "interactive" ]] ; then
	lxc-attach -n ${CONTAINER_NAME}
else
	# copy configs from template
	[[ -d template/${CONTAINER_NAME} ]] && cp -a template/${CONTAINER_NAME}/* /var/lib/lxc/${CONTAINER_NAME}

	lxc-attach -n ${CONTAINER_NAME} -- eselect news read
	lxc-attach -n ${CONTAINER_NAME} -- emerge -uDN world --with-bdeps=y --backtrack=200
	lxc-attach -n ${CONTAINER_NAME} -- etc-update -p # do trivial merges
	lxc-attach -n ${CONTAINER_NAME} -- rm /var/tmp/portage/* -rf
fi
lxc-stop -n ${CONTAINER_NAME}
