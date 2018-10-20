#!/bin/bash
set -e
set -x

emerge -uDN world -j1
webapp-config -I www-apps/nextcloud 13.0.7 -d nextcloud -s nginx
rc-update add nginx default
rc-update add php-fpm default
rc-update add mysql default
