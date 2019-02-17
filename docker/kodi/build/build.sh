#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

CNAME=kodi-builder

docker build . -t "internal/$CNAME:latest"

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != $CNAME ]]
then
	docker run \
		--cap-add SYS_PTRACE \
		--tmpfs /run \
		-v /usr/portage:/usr/portage:ro \
		-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
		-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
		--name "kodi-builder" \
		"internal/kodi-builder:latest" \
			bash /container-specific-setup.sh
else
	docker start -a kodi-builder
fi

docker commit \
	"$CNAME" \
	"slangenmaier/kodi:latest"

docker tag "slangenmaier/kodi:latest" "slangenmaier/kodi:${DATE}"
