docker run \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
        -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
        -v /mnt/full-data/vols/nextcloud-config/letsencrypt:/etc/letsencrypt:rw \
        -v /mnt/full-data/vols/nextcloud-data:/data/nextcloud:rw \
        -v /mnt/full-data/vols/nextcloud-config/nextcloud/config.php:/var/www/localhost/htdocs/nextcloud/config/config.php:rw \
        -v /mnt/full-data/vols/nextcloud-config/nginx/nginx.conf:/etc/nginx/nginx.conf:rw \
        -v /mnt/full-data/vols/nextcloud-config/php/fpm-php7.2/fpm.d/www.conf:/etc/php/fpm-php7.2/fpm.d/www.conf:rw \
        -v /mnt/full-data/vols/nextcloud-config/php/fpm-php7.2/php.ini:/etc/php/fpm-php7.2/php.ini:rw \
        -v /mnt/full-data/vols/nextcloud-config/mysql/my.cnf:/etc/mysql/my.cnf:rw \
        -v /mnt/full-data/vols/nextcloud-db:/var/lib/mysql:rw \
	-p 443:443 \
	-p 80:80 \
	--rm \
	-d \
        --name "nextcloud" \
        "slangenmaier/nextcloud:latest" \
	        /sbin/init