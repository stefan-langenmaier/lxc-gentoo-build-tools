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
	-v /root/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
	-v /root/.ssh/known_hosts:/root/.ssh/known_hosts:ro \
	--name "autodeploy-image-builder" \
	"slangenmaier/autodeploy:latest" \
		/bin/bash /build-image.sh