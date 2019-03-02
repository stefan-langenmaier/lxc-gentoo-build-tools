#!/bin/bash
set -e
set -x

emerge -uDN world -j1
eselect news read

if webapp-config -li | grep nextcloud
then
	webapp-config -U www-apps/nextcloud 14.0.8 -d nextcloud -s nginx
else
	webapp-config -I www-apps/nextcloud 14.0.8 -d nextcloud -s nginx
	rc-update add nginx default
	rc-update add php-fpm default
	rc-update add mysql default

	#write out current crontab
	crontab -l > mycron || true
	#echo new cron into cron file
	echo "*/15 * * * * /bin/su nginx -s /usr/bin/php /var/www/localhost/htdocs/nextcloud/cron.php" >> mycron
	echo "13 5 * * * /usr/bin/certbot renew --nginx" >> mycron
	#install new cron file
	crontab mycron
	rm mycron
	rc-update add cronie default
fi
emerge --depclean
