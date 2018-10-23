#!/bin/bash

docker run \
	--tmpfs /run \
        -v /mnt/full-data/vols/nextcloud-data:/data/nextcloud:rw \
        -v /data/nextcloud-config/letsencrypt:/etc/letsencrypt:rw \
        -v /data/nextcloud-config/nextcloud/config.php:/var/www/localhost/htdocs/nextcloud/config/config.php:rw \
        -v /data/nextcloud-config/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
        -v /data/nextcloud-config/php/fpm-php7.2/fpm.d/www.conf:/etc/php/fpm-php7.2/fpm.d/www.conf:ro \
	-p 443:443 \
	-p 80:80 \
	--rm \
	-d \
        --name "nextcloud-emilie" \
        "slangenmaier/nextcloud:2018-10-20" \
	        /sbin/init

