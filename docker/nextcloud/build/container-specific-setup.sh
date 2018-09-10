#!/bin/bash

emerge -uDN world -j4
webapp-config -I www-apps/nextcloud 13.0.5 -d nextcloud -s nginx
rc-update add nginx default
rc-update add php-fpm default
rc-update add mysql default
