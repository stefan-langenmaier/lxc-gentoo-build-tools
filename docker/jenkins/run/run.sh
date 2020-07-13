#!/bin/bash
set -e
set -x

docker run \
	--rm \
	--privileged \
	-d \
	--tmpfs /run \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /usr/bin/docker:/usr/bin/docker \
	-v /root/.docker/config.json:/home/jenkins/.docker/config.json \
	-v /mnt/full-data/vols/jenkins-home:/var/lib/jenkins/home:rw \
	-v /mnt/full-data/vols/jenkins-home/workspace:/mnt/full-data/vols/jenkins-home/workspace:ro \
	-p 7070:8080 \
	--entrypoint="/sbin/init" \
	--name "jenkins" \
	"slangenmaier/jenkins:latest"
