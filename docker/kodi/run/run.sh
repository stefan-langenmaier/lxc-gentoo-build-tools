#!/bin/bash
set -e
set -x

docker run -it \
	--net host \
	--privileged \
	--rm \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/kodi-config:/root/.kodi:rw \
	-v /mnt/full-data/vols/tv:/data/tv:ro \
	-v /mnt/full-data/vols/music:/data/music:ro \
	-d \
	-entrypoint="/bin/bash" \
	--name "kodi" \
	"stefan-langenmaier/kodi:2018-07-22" \
		kodi

#docker commit \
#	"nextcloud-builder" \
#	"stefan-langenmaier/nextcloud:${DATE}"

#docker rm "nextcloud-builder"
