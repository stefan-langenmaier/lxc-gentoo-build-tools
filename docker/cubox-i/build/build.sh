#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/cubox-i-builder"

docker rm "cubox-i-builder" || true

docker run \
	--cap-add SYS_PTRACE \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "cubox-i-builder" \
	"internal/cubox-i-builder" \
		bash /container-specific-setup.sh

docker commit \
	"cubox-i-builder" \
	"slangenmaier/cubox-i:latest"

docker tag "slangenmaier/cubox-i:latest" "slangenmaier/cubox-i:${DATE}"
