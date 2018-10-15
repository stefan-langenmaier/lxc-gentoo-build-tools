#!/bin/bash
set -e
set -x

OUTER_FOLDER=/root/lxc-gentoo-build-tools/docker/autodeploy/run

docker run \
	-d \
	-v autodeploy-exchange:/autodeploy-exchange:rw \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "tar-builder" \
	"slangenmaier/autodeploy:latest" \
		/sbin/init || \
docker start tar-builder

docker export cubox-i-builder | xz > cuboxi.tar.xz
docker cp cuboxi.tar.xz tar-builder:/autodeploy-exchange/
docker stop tar-builder
