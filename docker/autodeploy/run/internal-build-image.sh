#!/bin/bash
set -e
set -x

cd /root

if [ -d "/root/cubox-i-autodeploy-image" ]
then
	rm -rf /root/cubox-i-autodeploy-image
fi

git clone "git@github.com:stefan-langenmaier/cubox-i-autodeploy-image.git"

cd /root/cubox-i-autodeploy-image

cp /autodeploy-exchange/SPL /root/cubox-i-autodeploy-image/u-boot-bin/
cp /autodeploy-exchange/u-boot.img /root/cubox-i-autodeploy-image/u-boot-bin/
cp /autodeploy-exchange/zImage /root/cubox-i-autodeploy-image/kernel-bin/
cp /autodeploy-exchange/imx6q-cubox-i.dtb /root/cubox-i-autodeploy-image/kernel-bin/
cp /autodeploy-exchange/imx6q-cubox-i-emmc-som-v15.dtb /root/cubox-i-autodeploy-image/kernel-bin/
cp /autodeploy-exchange/imx6q-cubox-i-som-v15.dtb /root/cubox-i-autodeploy-image/kernel-bin/

bash create-autodeploy-image.sh

if [ ! -z ${TOKEN} ]; then
	echo "TOKEN SET"
	git config --global user.email "stefan.langenmaier@gmail.com"
	git config --global user.name "Stefan Langenmaier"
	bash create-tag.sh
	echo "exit code of create-tag.sh:  $?"
fi
