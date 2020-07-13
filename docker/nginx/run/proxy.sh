#!/bin/bash

docker run \
	--tmpfs /run \
	--network airrow \
        -v /mnt/full-data/vols/files/:/data/files:rw \
        -v /mnt/full-data/vols/mensa/:/data/mensa:rw \
        -v /mnt/full-data/vols/proxy/letsencrypt:/etc/letsencrypt:rw \
        -v /mnt/full-data/vols/proxy/nginx/nginx.conf:/etc/nginx/nginx.conf:rw \
	-p 443:443 \
	-p 80:80 \
	--rm \
	-d \
        --stop-signal SIGPWR \
	--name "proxy" \
        "slangenmaier/nginx:latest" \
        /sbin/init

