#!/bin/bash

docker run \
	--tmpfs /run \
	--network airrow \
        -v /data/container-packages:/usr/portage/packages:rw \
        -v /mnt/full-data/vols/mariadb/db-config/mysql/99-mariadb-overwrite.cnf:/etc/mysql/mariadb.d/99-mariadb-overwrite.cnf:rw \
        -v /mnt/full-data/vols/mariadb/db:/var/lib/mysql:rw \
	--rm \
	-d \
        --name "mariadb" \
        "slangenmaier/mariadb:latest" \
        /sbin/init

