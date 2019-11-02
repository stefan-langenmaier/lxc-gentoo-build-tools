#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

CNAME=monitoring-agent-builder

OLD_IMAGE_ID=$(docker images --filter=reference='internal/monitoring-agent-builder:latest' --format '{{.ID}}')

docker build . -t "internal/$CNAME:latest"

NEW_IMAGE_ID=$(docker images --filter=reference='internal/monitoring-agent-builder:latest' --format '{{.ID}}')

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != '' && $NEW_IMAGE_ID != $OLD_IMAGE_ID ]]
then
	docker rm "$CNAME"
fi


if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != $CNAME ]]
then
	docker run \
		--cap-add SYS_PTRACE \
		--tmpfs /run \
		-v /usr/portage:/usr/portage:ro \
		-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
		-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
		--name "$CNAME" \
		"internal/${CNAME}:latest" \
			bash /container-specific-setup.sh
else
	docker start -a $CNAME
fi

docker commit \
	"$CNAME" \
	"slangenmaier/monitoring-agent:latest"

docker tag "slangenmaier/monitoring-agent:latest" "slangenmaier/monitoring-agent:${DATE}"
