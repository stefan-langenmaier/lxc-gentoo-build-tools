#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/backup-builder:latest"

docker rm "backup-builder" || true

docker run  \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "backup-builder" \
	"internal/backup-builder:latest" \
		bash /container-specific-setup.sh

docker commit \
	"backup-builder" \
	"slangenmaier/backup:latest"

docker tag "slangenmaier/backup:latest" "slangenmaier/backup:${DATE}"
