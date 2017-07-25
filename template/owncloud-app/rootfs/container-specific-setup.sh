#!/bin/bash

# db install
emerge --config dev-db/mariadb
cp /etc/mysql/my.cnf.single /etc/mysql/my.cnf

# webinstall
webapp-config -I www-apps/nextcloud 12.0.0 -d nextcloud -s nginx

# copy nextcloud config
mv /config.php /var/www/localhost/htdocs/nextcloud/config/config.php
chown nginx:nginx /var/www/localhost/htdocs/nextcloud/config/config.php

# create file structure
mkdir -p /data/nextcloud/tmp
chown nginx:nginx /data/nextcloud/tmp/
mkdir -p /data/nextcloud/files_external
chown nginx:nginx /data/nextcloud/files_external/

## migrate nextcloud
cd /var/www/localhost/htdocs/nextcloud
su nginx -s /bin/bash -c "php occ upgrade"

# replace by certbot-nginx and creation on first start
# certbot certonly --standalone --cert-name nc-certs -d owncloud.quebec.langenmaier.net --email stefan.langenmaier+mozilla@gmail.com --non-interactive --agree-tos
