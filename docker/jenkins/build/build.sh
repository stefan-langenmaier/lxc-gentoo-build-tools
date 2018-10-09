#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`

docker build . -t "internal/jenkins-builder:${DATE}"

docker rm "jenkins-builder" || true

docker run  \
	--cap-add SYS_PTRACE \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-entrypoint="/bin/bash" \
	--name "jenkins-builder" \
	"internal/jenkins-builder:${DATE}" \
		bash /container-specific-setup.sh

docker commit \
	"jenkins-builder" \
	"slangenmaier/jenkins:latest"

docker tag "slangenmaier/jenkins:latest" "slangenmaier/jenkins:${DATE}"
