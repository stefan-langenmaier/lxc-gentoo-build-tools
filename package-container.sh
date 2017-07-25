#!/bin/bash

set -eux

CONTAINER_NAME=cubox-i

mountpoint -q /mnt/full-root/ || mount /mnt/full-root
btrfs sub snap /mnt/full-root/vols/${CONTAINER_NAME}/rootfs /mnt/full-root/vols/${CONTAINER_NAME}/rootfs-temp
btrfs property set -ts /mnt/full-root/vols/${CONTAINER_NAME}/rootfs-temp ro true
mkdir -p .packaged-subvolumes
btrfs send -vvv /mnt/full-root/vols/${CONTAINER_NAME}/rootfs-temp | xz --threads=2 > .packaged-subvolumes/${CONTAINER_NAME}.xz
btrfs sub delete /mnt/full-root/vols/${CONTAINER_NAME}/rootfs-temp
