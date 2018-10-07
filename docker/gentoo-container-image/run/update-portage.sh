#!/bin/bash
set -e
set -x
#	--privileged \
#	-v /sys/fs/cgroup:/sys/fs/cgroup:rw \

docker run  \
	--rm \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:rw \
	--entrypoint="/sbin/init" \
	--name "gentoo-container" \
	"slangenmaier/gentoo-container-image:latest" \
		emerge --sync

#docker commit \
#	"nextcloud-builder" \
#	"stefan-langenmaier/nextcloud:${DATE}"

#docker rm "nextcloud-builder"
