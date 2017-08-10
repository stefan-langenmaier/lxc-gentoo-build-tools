#!/bin/bash

# webinstall
webapp-config -I www-apps/nextcloud 12.0.1 -d nextcloud -s nginx

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

certbot certonly --standalone -d emilie.nextcloud.langenmaier.net --email stefan.langenmaier+mozilla@gmail.com --non-interactive --agree-tos
