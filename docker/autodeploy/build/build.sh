#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/autodeploy-builder:latest"

docker rm "autodeploy-builder" || true

docker run \
	--cap-add SYS_PTRACE \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	--name "autodeploy-builder" \
	"internal/autodeploy-builder:latest" \
		bash /container-specific-setup.sh

docker commit \
	"autodeploy-builder" \
	"slangenmaier/autodeploy:latest"

docker tag "slangenmaier/autodeploy:latest" "slangenmaier/autodeploy:${DATE}"
