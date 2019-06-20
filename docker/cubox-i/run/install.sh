#!/bin/bash

set -e
set -x

mount /mnt/full-root/ || true

NOW=$(date +"%Y-%m-%d")
NEW_ROOT=/mnt/full-root/vols/root-${NOW}
#btrfs sub create ${NEW_ROOT}
#docker export cubox-i-builder | tar --extract --verbose --directory ${NEW_ROOT}

rm ${NEW_ROOT}/.dockerenv

FILES="fstab
ddclient/ddclient.conf
inittab
shadow
conf.d/hostname
conf.d/net
docker/
init.d/net.eth0
local.d/
runlevels/
ssh/"
for f in $FILES
do
	rsync -a /etc/${f} ${NEW_ROOT}/etc/${f}
done

FILES=".ssh/"
for f in $FILES
do
	rsync -a /root/${f} ${NEW_ROOT}/root/${f}
done

mkdir /mnt/full-root
mkdir /mnt/full-data

echo "Remember to update extlinux.conf"
