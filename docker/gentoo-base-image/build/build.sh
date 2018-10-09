#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m`

docker rm gentoo-base-container || true

docker run \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "gentoo-base-container" \
	"slangenmaier/gentoo-base-image:latest" \
		emerge -uDN world

docker export gentoo-base-container | docker import - "slangenmaier/gentoo-base-image:latest"

docker tag "slangenmaier/gentoo-base-image:latest" "slangenmaier/gentoo-base-image:${DATE}"
