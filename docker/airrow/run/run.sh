#!/bin/bash

docker run \
	-d \
	--rm \
	--network airrow \
	-v /mnt/full-data/vols/airrow/app/application.properties:/config/application.properties:rw \
	-p 6060:8080 \
	-e DEBUG=true \
	-e SEARCH_WALK_DISTANCE=1500 \
	-e SEARCH_MIN_ACCURACY=25 \
        --name "airrow" \
        "slangenmaier/airrow-jvm:latest" \
	/opt/openjdk-bin-11/bin/java -jar /deployments/app.jar
