#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	--net host \
	--privileged \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/nextcloud-data/christina.langenmaier/files/:/data/christina:ro \
	-v /mnt/full-data/vols/nextcloud-data/matthew.hart/files/:/data/matthew:ro \
	-v /mnt/full-data/vols/kodi-config:/root/.kodi:rw \
	-entrypoint="/bin/bash" \
	--name "kodi" \
	"slangenmaier/kodi:latest" \
		kodi
