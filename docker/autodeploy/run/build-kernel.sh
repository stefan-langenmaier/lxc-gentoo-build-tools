#!/bin/bash
set -e
set -x

docker run \
	-v internal-build-kernel.sh:/build-kernel.sh:ro \
	-v kernel-config:/kernel-config:ro\
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "kernel-builder" \
	"slangenmaier/autodeploy:latest" \
		/bin/bash /build-kernel.sh || \
docker start kernel-builder
