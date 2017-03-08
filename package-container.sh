#!/bin/bash

set -eux

CONTAINER_NAME=cubox-i

mountpoint -q /mnt/full-root/ || mount /mnt/full-root
btrfs sub snap /mnt/full-root/vols/${CONTAINER_NAME} /mnt/full-root/vols/${CONTAINER_NAME}-temp
btrfs sub create /mnt/full-root/vols/${CONTAINER_NAME}-temp/newrootfs
mv  /mnt/full-root/vols/${CONTAINER_NAME}-temp/rootfs/* /mnt/full-root/vols/${CONTAINER_NAME}-temp/newrootfs/
btrfs property set -ts /mnt/full-root/vols/${CONTAINER_NAME}-temp/newrootfs ro true
mkdir -p .packaged-subvolumes
btrfs send -vvv /mnt/full-root/vols/${CONTAINER_NAME}-temp/newrootfs | xz > .packaged-subvolumes/${CONTAINER_NAME}.xz
btrfs sub delete /mnt/full-root/vols/${CONTAINER_NAME}-temp/newrootfs
btrfs sub delete /mnt/full-root/vols/${CONTAINER_NAME}-temp
