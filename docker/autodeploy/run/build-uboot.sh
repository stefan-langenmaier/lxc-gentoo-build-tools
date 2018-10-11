#!/bin/bash
set -e
set -x

docker run \
	-v ${PWD}/internal-build-uboot.sh:/build-uboot.sh:ro \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "uboot-builder" \
	"slangenmaier/autodeploy:latest" \
		/bin/bash /build-uboot.sh || \
docker start -a uboot-builder
