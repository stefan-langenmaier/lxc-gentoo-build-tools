#!/bin/bash
set -e
set -x
#	--privileged \
#	-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
#	--cap-add=SYS_BOOT \


docker run -it \
	--rm \
	--tmpfs /run \
	--tmpfs /tmp \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--entrypoint="/sbin/init" \
	--name "gentoo-container" \
	"slangenmaier/gentoo-container-image:latest"
