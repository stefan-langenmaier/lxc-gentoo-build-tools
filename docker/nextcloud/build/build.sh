#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/nextcloud-builder:latest"

CNAME=nextcloud-builder

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != $CNAME ]]
then
	docker run \
		--cap-add SYS_PTRACE \
		--tmpfs /run \
		-v /usr/portage:/usr/portage:ro \
		-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
		-v /mnt/full-data/vols/cuboxi-packages/:/usr/portage/packages:rw \
		--name $CNAME \
		"internal/nextcloud-builder:latest" \
			bash /container-specific-setup.sh
else
	docker start -a $CNAME
fi

docker commit \
	$CNAME \
	"slangenmaier/nextcloud:latest"

docker tag "slangenmaier/nextcloud:latest" "slangenmaier/nextcloud:${DATE}"
