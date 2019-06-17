#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

CNAME=rygel-builder

docker build . -t "internal/$CNAME:latest"

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') != $CNAME ]]
then
	docker run \
		--cap-add SYS_PTRACE \
		--tmpfs /run \
		-v /usr/portage:/usr/portage:ro \
		-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
		-v /mnt/full-data/vols/cuboxi-packages/:/usr/portage/packages:rw \
		--name $CNAME \
		"internal/$CNAME:latest" \
			bash /container-specific-setup.sh
else
	docker start -a $CNAME
fi

docker commit \
	$CNAME \
	"slangenmaier/rygel:latest"

docker tag "slangenmaier/rygel:latest" "slangenmaier/rygel:${DATE}"
