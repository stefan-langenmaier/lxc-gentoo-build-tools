#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m`

CNAME=gentoo-base-container

if [[ $(docker ps -a --filter "name=^/$CNAME$" --format '{{.Names}}') = $CNAME ]]
then
	docker rm $CNAME
fi

docker run \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /var/lib/jenkins/home/workspace/build-gentoo-base-image/docker/gentoo-base-image/build/container-specific-setup.sh:/css.sh:ro \
	--name $CNAME \
	"slangenmaier/gentoo-base-image:latest" \
		bash /css.sh

#to lose the history and flatten the image
docker export $CNAME | docker import - "slangenmaier/gentoo-base-image:latest"

docker tag "slangenmaier/gentoo-base-image:latest" "slangenmaier/gentoo-base-image:${DATE}"
