#!/bin/bash
set -e
set -x

docker run -it \
	--rm \
	--privileged \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "kodi" \
	"slangenmaier/kodi:2018-07-17" \
		/bin/bash

#docker commit \
#	"nextcloud-builder" \
#	"stefan-langenmaier/nextcloud:${DATE}"

#docker rm "nextcloud-builder"
