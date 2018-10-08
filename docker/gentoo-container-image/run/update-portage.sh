#!/bin/bash
set -e
set -x

docker run  \
	--rm \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:rw \
	--name "update-portage" \
	"slangenmaier/gentoo-container-image:latest" \
		emerge --sync
