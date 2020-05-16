#!/bin/bash

docker run \
	--tmpfs /run \
	--network airrow \
	-v /usr/portage:/usr/portage:ro \
        -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
        -v /data/container-packages:/usr/portage/packages:rw \
        -v /mnt/full-data/vols/files/:/data/files:rw \
        -v /mnt/full-data/vols/airrow/db-config/letsencrypt:/etc/letsencrypt:rw \
        -v /mnt/full-data/vols/airrow/db-config/nginx/nginx.conf:/etc/nginx/nginx.conf:rw \
	-p 443:443 \
	-p 80:80 \
	--rm \
	-d \
        --stop-signal SIGPWR \
	--name "proxy" \
        "slangenmaier/nginx-slim:latest" \
        /sbin/init

