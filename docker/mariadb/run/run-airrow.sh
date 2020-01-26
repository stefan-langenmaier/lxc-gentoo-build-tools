#!/bin/bash

docker run \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
        -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
        -v /data/container-packages:/usr/portage/packages:rw \
        -v /mnt/full-data/vols/airrow/db-config/mysql/99-mariadb-overwrite.cnf:/etc/mysql/mariadb.d/99-mariadb-overwrite.cnf:rw \
        -v /mnt/full-data/vols/airrow/db:/var/lib/mysql:rw \
	--rm \
	--network airrow \
	-d \
        --name "airrow-mariadb" \
        "slangenmaier/mariadb:latest" \
        /sbin/init

