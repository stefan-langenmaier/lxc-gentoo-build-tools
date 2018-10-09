#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/nextcloud-builder:latest"

docker rm "nextcloud-builder" || true

docker run -it \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages/:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "nextcloud-builder" \
	"internal/nextcloud-builder:latest" \
		bash /container-specific-setup.sh

docker commit \
	"nextcloud-builder" \
	"slangenmaier/nextcloud:latest"

docker tag "slangenmaier/nextcloud:latest" "slangenmaier/nextcloud:${DATE}"

#docker rm "nextcloud-builder"
