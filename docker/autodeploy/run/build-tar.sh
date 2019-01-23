#!/bin/bash
set -e
set -x

OUTER_FOLDER=/root/lxc-gentoo-build-tools/docker/autodeploy/run

CNAME="tar-builder"

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != $CNAME ]]
then
	docker run \
		--privileged \
		--tmpfs /run \
		-v ${OUTER_FOLDER}/internal-build-tar.sh:/build-tar.sh:ro \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v /usr/bin/docker:/usr/bin/docker \
		-v autodeploy-exchange:/autodeploy-exchange:rw \
		-v /usr/portage:/usr/portage:ro \
		-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
		-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
		--name $CNAME \
		"slangenmaier/autodeploy:latest" \
			bash /build-tar.sh
else
	docker start -a $CNAME
fi
