#!/bin/bash

docker run \
	--tmpfs /run \
        -v /mnt/full-data/vols/nextcloud-data:/data/nextcloud:rw \
        -v /mnt/full-data/vols/nextcloud-config/letsencrypt:/etc/letsencrypt:rw \
        -v /mnt/full-data/vols/nextcloud-config/nextcloud/config.php:/var/www/localhost/htdocs/nextcloud/config/config.php:rw \
        -v /mnt/full-data/vols/nextcloud-config/nginx/nginx.conf:/etc/nginx/nginx.conf:rw \
        -v /mnt/full-data/vols/nextcloud-config/php/fpm-php7.3/fpm.d/www.conf:/etc/php/fpm-php7.3/fpm.d/www.conf:ro \
        -v /mnt/full-data/vols/nextcloud-config/php/fpm-php7.3/php.ini:/etc/php/fpm-php7.3/php.ini:ro \
	-p 443:443 \
	-p 80:80 \
	--rm \
	-d \
        --stop-signal SIGPWR \
        --name "nextcloud" \
        "slangenmaier/nextcloud:latest" \
	        /sbin/init
sleep 10
docker exec nextcloud su - nginx -s /bin/bash -c 'cd /var/www/localhost/htdocs/nextcloud ; php occ upgrade'
