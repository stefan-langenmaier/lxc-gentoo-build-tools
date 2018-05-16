#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/nextcloud-builder:${DATE}"

docker rm "nextcloud-builder"

docker run -it \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/container-packages:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "nextcloud-builder" \
	"internal/nextcloud-builder:${DATE}" \
		bash /container-specific-setup.sh

docker commit \
	"nextcloud-builder" \
	"stefan-langenmaier/nextcloud:${DATE}"

docker rm "nextcloud-builder"
