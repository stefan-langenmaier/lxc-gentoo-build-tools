#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker run -it \
	--cap-add SYS_PTRACE \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-entrypoint="/bin/bash" \
	--name "gentoo-base-container" \
	"slangenmaier/stage3-arm-armv7a_hardfp:latest"

#docker commit \
#	"nextcloud-builder" \
#	"slangenmaier/nextcloud:${DATE}"
#
#docker rm "nextcloud-builder"
