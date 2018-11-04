#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/cuboxi-packages:/usr/portage/packages:rw \
	--entrypoint="/sbin/init" \
	--name "backup" \
		"slangenmaier/backup:2018-11-01"
