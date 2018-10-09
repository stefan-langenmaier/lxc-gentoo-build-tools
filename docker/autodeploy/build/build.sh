#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/autodeploy-builder:${DATE}"

docker rm "autodeploy-builder" || true

docker run -it \
	--cap-add SYS_PTRACE \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "autodeploy-builder" \
	"internal/autodeploy-builder:${DATE}" \
		bash /container-specific-setup.sh

docker commit \
	"autodeploy-builder" \
	"slangenmaier/autodeploy:${DATE}"
