#!/bin/bash
set -e
set -x

docker run \
	--rm \
	--privileged \
	-d \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/container-profiles:/mnt/full-data/vols/container-profiles:ro \
	-v /mnt/full-data/vols/common-builder/nginx/:/mnt/full-data/vols/common-builder/nginx:rw \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /usr/bin/docker:/usr/bin/docker \
	-v /root/.docker/config.json:/var/lib/jenkins/.docker/config.json \
	-v /mnt/full-data/vols/jenkins-home:/var/lib/jenkins/home:rw \
	-v /mnt/full-data/vols/jenkins-home/workspace:/mnt/full-data/vols/jenkins-home/workspace:ro \
	-p 7070:8080 \
	--entrypoint="/sbin/init" \
	--name "jenkins" \
	"slangenmaier/jenkins:latest"
