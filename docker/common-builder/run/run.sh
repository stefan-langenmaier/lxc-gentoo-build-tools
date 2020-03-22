#!/bin/bash
set -e
set -x

docker run -d \
	--rm \
	--tmpfs /tmp \
	--tmpfs /run \
	--stop-signal SIGPWR \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/container-profiles/:/usr/local/portage/container-profiles:ro \
	-v /mnt/full-data/vols/common-builder-config/container-profiles.conf:/etc/portage/repos.conf/container-profiles.conf:ro \
	-v /root/lxc-gentoo-build-tools/docker:/build/configs:ro \
	-v /mnt/full-data/vols/common-builder:/build/rootfs:rw \
	--entrypoint="/sbin/init" \
	--name "common-builder-instance" \
	"slangenmaier/common-builder-image:latest"

