#!/bin/bash
set -e
set -x

docker run \
	-v ${PWD}/internal-build-kernel.sh:/build-kernel.sh:ro \
	-v ${PWD}/kernel-config:/kernel-config:ro\
	-v autodeploy-exchange:/autodeploy-exchange:rw \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "kernel-builder" \
	"slangenmaier/autodeploy:latest" \
		/bin/bash /build-kernel.sh || \
docker start -a kernel-builder
