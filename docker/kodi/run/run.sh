#!/bin/bash
set -e
set -x

docker run -it \
	--net host \
	--privileged \
	--rm \
	-d \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/kodi-config:/root/.kodi:rw \
	-v /mnt/full-data/vols/tv:/data/tv:ro \
	-v /mnt/full-data/vols/music:/data/music:ro \
	--name "kodi" \
	"slangenmaier/kodi:latest" \
		kodi
