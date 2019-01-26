#!/bin/bash
set -e
set -x
#	--privileged \
#	-v /sys/fs/cgroup:/sys/fs/cgroup:rw \

docker run -it \
	--rm \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-p 8080:8080 \
	--entrypoint="/sbin/init" \
	--name "gentoo-container" \
	"slangenmaier/gentoo-container-image:latest" #\
#		/bin/bash

#docker commit \
#	"nextcloud-builder" \
#	"stefan-langenmaier/nextcloud:${DATE}"

#docker rm "nextcloud-builder"
