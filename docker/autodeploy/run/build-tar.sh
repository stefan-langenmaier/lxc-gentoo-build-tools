#!/bin/bash
set -e
set -x

OUTER_FOLDER=/root/lxc-gentoo-build-tools/docker/autodeploy/run

docker run \
	-it \
	--privileged \
	--tmpfs /run \
	-v ${OUTER_FOLDER}/internal-build-tar.sh:/build-tar.sh:ro \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /usr/bin/docker:/usr/bin/docker \
	-v autodeploy-exchange:/autodeploy-exchange:rw \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "tar-builder" \
	"slangenmaier/autodeploy:latest" \
		bash /build-tar.sh || \
docker start tar-builder
