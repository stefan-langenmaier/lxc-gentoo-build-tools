#!/bin/bash
set -e
set -x

docker run \
	--rm \
	--privileged \
	-d \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/tv/Neu:/var/lib/transmission/downloads:rw \
	-v /mnt/full-data/vols/transmission-config:/var/lib/transmission/config:rw \
	-p 6060:8080 \
	--entrypoint="/sbin/init" \
	--name "transmission" \
	"slangenmaier/transmission:latest"
