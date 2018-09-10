#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/cubox-i-builder"

docker rm "cubox-i-builder" || true

docker run -it \
	--cap-add SYS_PTRACE \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "cubox-i-builder" \
	"internal/cubox-i-builder" \
		bash /container-specific-setup.sh

docker commit \
	"cubox-i-builder" \
	"slangenmaier/cubox-i:${DATE}"

#docker rm "nextcloud-builder"
