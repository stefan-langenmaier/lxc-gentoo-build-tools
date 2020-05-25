#!/bin/bash
set -e
set -x

cd /root/cubox-i-autodeploy-image

bash create-autodeploy-image.sh

if [ ! -z ${TOKEN} ]; then
	echo "TOKEN SET"
	git config --global user.email "stefan.langenmaier@gmail.com"
	git config --global user.name "Stefan Langenmaier"
	bash create-tag.sh
	echo "exit code of create-tag.sh:  $?"
fi
