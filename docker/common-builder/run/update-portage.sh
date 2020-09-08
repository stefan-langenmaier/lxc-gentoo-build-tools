#!/bin/bash
set -e
set -x

docker run \
	--rm \
	--privileged \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:rw \
	--name "update-portage" \
	"slangenmaier/common-builder:latest" \
		emerge --sync
