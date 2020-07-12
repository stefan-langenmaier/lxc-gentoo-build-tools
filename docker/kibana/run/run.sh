#!/bin/bash

docker run \
	--tmpfs /run \
	-v /mnt/full-data/vols/kibana-config/kibana.yml:/etc/kibana/kibana.yml:ro \
	-v /mnt/full-data/vols/kibana-config/kibana:/etc/conf.d/kibana:ro \
	--network=es \
	--rm \
	-p 5601:5601 \
	-d \
        --name "kibana" \
	"slangenmaier/kibana:latest" \
        /sbin/init

