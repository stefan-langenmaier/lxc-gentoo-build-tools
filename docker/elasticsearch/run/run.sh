#!/bin/bash

docker run \
	--tmpfs /run \
        -v /mnt/full-data/vols/elasticsearch-data:/var/lib/elasticsearch:rw \
        -v /mnt/full-data/vols/elasticsearch-config/elasticsearch:/etc/elasticsearch:rw \
	--network=es \
	-p 9200:9200 \
	-p 9300:9300 \
	--rm \
	-d \
        --name "elasticsearch" \
	"slangenmaier/elasticsearch:latest" \
        /sbin/init

