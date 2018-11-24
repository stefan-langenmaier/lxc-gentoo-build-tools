#!/bin/bash
set -e
set -x

OUTER_FOLDER=/root/lxc-gentoo-build-tools/docker/autodeploy/run

CNAME=kernel-builder

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != $CNAME ]]
then
	docker run \
		-v ${OUTER_FOLDER}/internal-build-kernel.sh:/build-kernel.sh:ro \
		-v ${OUTER_FOLDER}/kernel-config:/kernel-config:rw \
		-v autodeploy-exchange:/autodeploy-exchange:rw \
		-v /usr/portage:/usr/portage:ro \
		-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
		-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
		--name "$CNAME" \
		"slangenmaier/autodeploy:latest" \
			/bin/bash /build-kernel.sh
else
	docker start -a $CNAME
fi
