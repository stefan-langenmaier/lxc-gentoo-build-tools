#!/bin/bash
set -e
set -x

if [ ! -d "/root/cubox-i-autodeploy-image" ]
then
    	cd /root
        git clone "https://github.com/stefan-langenmaier/cubox-i-autodeploy-image"
#else
#       git fetch
fi
cd /root/cubox-i-autodeploy-image

cp /autodeploy-exchange/SPL /root/cubox-i-autodeploy-image/u-boot-bin/
cp /autodeploy-exchange/u-boot.img /root/cubox-i-autodeploy-image/u-boot-bin/
cp /autodeploy-exchange/zImage /root/cubox-i-autodeploy-image/kernel-bin/
cp /autodeploy-exchange/u-boot.img /root/cubox-i-autodeploy-image/kernel-bin/

bash create-autodeploy-image.sh
