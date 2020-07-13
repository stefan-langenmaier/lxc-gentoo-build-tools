#!/bin/bash

docker run \
	--rm \
	--network airrow \
	-v /mnt/full-data/vols/airrow/app/application.properties:/config/application.properties:rw \
	-d \
	-p 6060:8080 \
        --name "airrow" \
        "slangenmaier/airrow-jvm:latest" \
	java -jar /deployments/app.jar
