#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/cubox-i-builder"

CNAME=cubox-i-builder

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') = $CNAME ]]
then
	docker rm "cubox-i-builder"
fi

docker run \
	--cap-add SYS_PTRACE \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name $CNAME \
	"internal/cubox-i-builder" \
		bash /container-specific-setup.sh

docker commit \
	$CNAME \
	"slangenmaier/cubox-i:latest"

docker tag "slangenmaier/cubox-i:latest" "slangenmaier/cubox-i:${DATE}"
