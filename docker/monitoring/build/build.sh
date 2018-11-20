#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/monitoring-builder:latest"

docker rm "monitoring-builder" || true

docker run  \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "monitoring-builder" \
	"internal/monitoring-builder:latest" \
		bash /container-specific-setup.sh

docker commit \
	"monitoring-builder" \
	"slangenmaier/monitoring:latest"

docker tag "slangenmaier/monitoring:latest" "slangenmaier/monitoring:${DATE}"
