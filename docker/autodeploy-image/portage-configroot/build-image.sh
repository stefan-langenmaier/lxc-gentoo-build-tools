#!/bin/bash
set -e
set -x

export TOKEN=$1
echo $TOKEN

cd /root/cubox-i-autodeploy-image

# just to make sure
losetup -D || /bin/true

bash create-autodeploy-image.sh

if [ ! -z ${TOKEN} ]; then
	echo "TOKEN SET"
	git config --global user.email "stefan.langenmaier@gmail.com"
	git config --global user.name "Stefan Langenmaier"
	bash create-tag.sh
	echo "exit code of create-tag.sh:  $?"
fi
