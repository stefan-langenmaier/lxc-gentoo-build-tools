#!/bin/bash
set -e
set -x

OUTER_FOLDER=/root/lxc-gentoo-build-tools/docker/autodeploy/run

TOKEN=$1

docker run \
	--privileged \
	--rm \
	-e TOKEN=$TOKEN \
	-v /dev/console:/dev/console:ro \
	-v ${OUTER_FOLDER}/internal-build-image.sh:/build-image.sh:ro \
	-v autodeploy-exchange:/autodeploy-exchange:rw \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "autodeploy-image-builder" \
	"slangenmaier/autodeploy:latest" \
		/bin/bash /build-image.sh
