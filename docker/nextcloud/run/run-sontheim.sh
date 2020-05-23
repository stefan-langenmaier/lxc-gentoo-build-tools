docker run \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
        -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
        -v /mnt/full-data/vols/nextcloud-config/letsencrypt:/etc/letsencrypt:rw \
        -v /mnt/full-data/vols/nextcloud-data:/data/nextcloud:rw \
        -v /mnt/full-data/vols/nextcloud-config/nextcloud/config.php:/var/www/localhost/htdocs/nextcloud/config/config.php:rw \
        -v /mnt/full-data/vols/nextcloud-config/nginx/nginx.conf:/etc/nginx/nginx.conf:rw \
        -v /mnt/full-data/vols/nextcloud-config/php/fpm-php7.3/fpm.d/www.conf:/etc/php/fpm-php7.3/fpm.d/www.conf:rw \
        -v /mnt/full-data/vols/nextcloud-config/php/fpm-php7.3/php.ini:/etc/php/fpm-php7.3/php.ini:rw \
        -v /mnt/full-data/vols/nextcloud-config/mysql/my.cnf:/etc/mysql/my.cnf:rw \
        -v /mnt/full-data/vols/nextcloud-db:/var/lib/mysql:rw \
	-p 443:443 \
	-p 80:80 \
	--stop-signal SIGPWR \
	--rm \
	-d \
        --name "nextcloud" \
        "slangenmaier/nextcloud:latest" \
	        /sbin/init

sleep 1
docker exec nextcloud su - nginx -s /bin/bash -c 'while ! /etc/init.d/mysql status >/dev/null ; do echo waiting ; sleep 1 ; done ; while ! /etc/init.d/redis status >/dev/null ; do echo waiting ; sleep 1 ; done ; cd /var/www/localhost/htdocs/nextcloud ; php occ upgrade'
