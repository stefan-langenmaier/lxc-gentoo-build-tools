#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "openvpn" \
	"slangenmaier/openvpn:latest" \
		/sbin/init
