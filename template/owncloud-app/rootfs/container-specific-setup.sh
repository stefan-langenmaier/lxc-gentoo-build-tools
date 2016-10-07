#!/bin/bash

# webinstall
webapp-config -I www-apps/nextcloud 10.0.1 -d nextcloud -s nginx

# copy owncloud config
mv /config.php /var/www/localhost/htdocs/nextcloud/config/config.php
chown nginx:nginx /var/www/localhost/htdocs/nextcloud/config/config.php

# create file structure
mkdir -p /data/owncloud/tmp
chown nginx:nginx /data/owncloud/tmp/
mkdir -p /data/owncloud/files_external
chown nginx:nginx /data/owncloud/files_external/

## migrate nextcloud
cd /var/www/localhost/htdocs/nextcloud
su nginx -s /bin/bash -c /create-nonexisting-user.sh

wget https://github.com/nextcloud/news/releases/download/9.0.4/news.tar.gz
tar xzf news.tar.gz --directory apps/
rm news.tar.gz

#su nginx -s /bin/bash -c "php occ upgrade"

su nginx -s /bin/bash -c "php occ app:list"
su nginx -s /bin/bash -c "php occ app:enable calendar"
su nginx -s /bin/bash -c "php occ app:enable contacts"
su nginx -s /bin/bash -c "php occ app:enable mail"
su nginx -s /bin/bash -c "php occ app:enable news"
#su nginx -s /bin/bash -c "php occ upgrade"

#su nginx -s /bin/bash -c php occ upgrade
#su nginx -s /bin/bash -c php occ upgrade
#su nginx -s /bin/bash -c php occ upgrade

certbot certonly --standalone -d owncloud.langenmaier.net --email stefan.langenmaier+mozilla@gmail.com --non-interactive --agree-tos
certbot certonly --standalone -d owncloud.germany.langenmaier.net --email stefan.langenmaier+mozilla@gmail.com --non-interactive --agree-tos
certbot certonly --standalone -d owncloud.manchester.langenmaier.net --email stefan.langenmaier+mozilla@gmail.com --non-interactive --agree-tos
certbot certonly --standalone -d owncloud.quebec.langenmaier.net --email stefan.langenmaier+mozilla@gmail.com --non-interactive --agree-tos

#/etc/init.d/php-fpm start
#/etc/init.d/nginx start
