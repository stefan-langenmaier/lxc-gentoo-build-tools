#!/bin/bash
set -e
set -x

mkdir -p $ROOTFS/root
cd $ROOTFS/root

if [ -d "$ROOTFS/root/cubox-i-autodeploy-image" ]
then
	rm -rf $ROOTFS/root/cubox-i-autodeploy-image
fi

git clone "https://github.com/stefan-langenmaier/cubox-i-autodeploy-image.git"

cd $ROOTFS/root/cubox-i-autodeploy-image

cp /etc/host.conf ${ROOTFS}/etc
cp /etc/nsswitch.conf ${ROOTFS}/etc
cp /etc/resolv.conf ${ROOTFS}/etc
cp /etc/inittab ${ROOTFS}/etc

mkdir -p $ROOTFS/proc/
mkdir -p $ROOTFS/dev/

if ! mountpoint -q ${ROOTFS}/dev
then
	mount --rbind /dev ${ROOTFS}/dev
fi

if ! mountpoint -q ${ROOTFS}/proc
then
	mount --types proc /proc ${ROOTFS}/proc

fi
