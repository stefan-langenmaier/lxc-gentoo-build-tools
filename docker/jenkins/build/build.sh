#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/jenkins-builder:latest"

docker rm "jenkins-builder" || true

docker run  \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	--name "jenkins-builder" \
	"internal/jenkins-builder:latest" \
		bash /container-specific-setup.sh

docker commit \
	"jenkins-builder" \
	"slangenmaier/jenkins:latest"

docker tag "slangenmaier/jenkins:latest" "slangenmaier/jenkins:${DATE}"
