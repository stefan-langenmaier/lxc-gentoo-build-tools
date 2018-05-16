#!/bin/bash

docker run \
	-v /usr/portage:/usr/portage:ro \
        -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
        -v /data/container-packages:/usr/portage/packages:rw \
        -v /data/nextcloud-config/letsencrypt:/etc/letsencrypt:rw \
        -v /mnt/full-data/vols/nextcloud-data-migration:/data/nextcloud:rw \
        -v /data/nextcloud-config/nextcloud/config.php:/var/www/localhost/htdocs/nextcloud/config/config.php:rw \
        -v /data/nextcloud-config/nginx/nginx.conf:/etc/nginx/nginx.conf:rw \
        -v /data/nextcloud-config/php/fpm-php7.1/fpm.d/www.conf:/etc/php/fpm-php7.1/fpm.d/www.conf:rw \
	-p 443:443 \
	-p 80:80 \
	--rm \
	-d \
        --name "nextcloud-emilie" \
        "stefan-langenmaier/nextcloud-emilie:2018-05-13" \
        /sbin/init

