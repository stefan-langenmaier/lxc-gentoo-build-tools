#!/bin/bash
set -e
set -x

OUTER_FOLDER=/root/lxc-gentoo-build-tools/docker/autodeploy/run

docker run \
	-v ${OUTER_FOLDER}/internal-build-uboot.sh:/build-uboot.sh:ro \
	-v autodeploy-exchange:/autodeploy-exchange:rw \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "uboot-builder" \
	"slangenmaier/autodeploy:latest" \
		/bin/bash /build-uboot.sh || \
docker start -a uboot-builder
