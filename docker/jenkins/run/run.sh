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
	-v /data/cuboxi-packages:/usr/portage/packages:rw \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /usr/bin/docker:/usr/bin/docker \
	-v /mnt/full-data/vols/jenkins-home:/var/lib/jenkins/home:rw \
	-p 8080:8080 \
	--entrypoint="/sbin/init" \
	--name "jenkins" \
	"slangenmaier/jenkins:latest"
