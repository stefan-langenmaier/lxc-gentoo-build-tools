#!/bin/bash

set -e
set -x

VERSION="v0.52"

if ! mountpoint -q /mnt/full-root ; then
	mount /mnt/full-root/
fi
if ! mountpoint -q /boot ; then
	mount /boot/
fi


NOW=$(date +"%Y-%m-%d-%H%M%S")
NEW_ROOT=/mnt/full-root/vols/root-${NOW}
BACKUP_BOOT=/boot/backup/$NOW


mkdir -p $BACKUP_BOOT
cp -R /boot/zImage /boot/extlinux /boot/dtbs $BACKUP_BOOT
wget https://github.com/stefan-langenmaier/cubox-i-autodeploy-image/releases/download/${VERSION}/zImage -O /boot/zImage
wget https://github.com/stefan-langenmaier/cubox-i-autodeploy-image/releases/download/${VERSION}/imx6q-cubox-i.dtb -O /boot/dtbs/imx6q-cubox-i.dtb
wget https://github.com/stefan-langenmaier/cubox-i-autodeploy-image/releases/download/${VERSION}/imx6q-cubox-i-emmc-som-v15.dtb -O /boot/dtbs/imx6q-cubox-i-emmc-som-v15.dtb
wget https://github.com/stefan-langenmaier/cubox-i-autodeploy-image/releases/download/${VERSION}/imx6q-cubox-i-som-v15.dtb -O /boot/dtbs/imx6q-cubox-i-som-v15.dtb

#exit

btrfs sub create ${NEW_ROOT}
docker rm cubox-i || true
docker create --name cubox-i slangenmaier/cubox-i:latest /bin/true
docker export cubox-i | tar --extract --verbose --directory ${NEW_ROOT}

rm ${NEW_ROOT}/.dockerenv

FILES="fstab
ddclient/ddclient.conf
inittab
shadow
conf.d/hostname
conf.d/net
conf.d/dmcrypt
keys/external-usb-disks.key
docker/
init.d/net.eth0
local.d/
runlevels/
ssh/"
for f in $FILES
do
	rsync -a /etc/${f} ${NEW_ROOT}/etc/${f} || echo "ERROR: ${f} not copied"
done

mkdir -p ${NEW_ROOT}/root/.ssh
mkdir -p ${NEW_ROOT}/root/.docker
FILES=".ssh/
.gitconfig
.docker/config.json"
for f in $FILES
do
	rsync -a /root/${f} ${NEW_ROOT}/root/${f} || echo "ERROR: ${f} not copied"
done

mkdir -p ${NEW_ROOT}/home
FILES="monitoring/"
for f in $FILES
do
	rsync -a /home/${f} ${NEW_ROOT}/home/${f} || echo "ERROR: ${f} not copied"
done

mkdir -p ${NEW_ROOT}/mnt/full-root
mkdir -p ${NEW_ROOT}/mnt/full-data

echo "Remember to update extlinux.conf"
echo "Remember to activate subvol as default"
