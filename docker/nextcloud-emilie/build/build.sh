#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/nextcloud-emilie-builder:${DATE}"

docker rm "nextcloud-emilie-builder"

docker run -it \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/container-packages:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "nextcloud-emilie-builder" \
	"internal/nextcloud-emilie-builder:${DATE}" \
		bash /container-specific-setup.sh

docker commit \
	"nextcloud-emilie-builder" \
	"stefan-langenmaier/nextcloud-emilie:${DATE}"

docker rm "nextcloud-emilie-builder"
