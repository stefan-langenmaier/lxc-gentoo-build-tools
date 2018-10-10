#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/kodi-builder:${DATE}"

docker rm "kodi-builder" || true

docker run \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "kodi-builder" \
	"internal/kodi-builder:${DATE}" \
		bash /container-specific-setup.sh

docker commit \
	"kodi-builder" \
	"slangenmaier/kodi:latest"

docker tag "slangenmaier/kodi:latest" "slangenmaier/kodi:${DATE}"
