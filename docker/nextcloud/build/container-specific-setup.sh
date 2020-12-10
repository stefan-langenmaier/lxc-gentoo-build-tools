#!/bin/bash
set -e
set -x

NC_VERSION=18.0.12
mkdir -p $ROOTFS/var/db/webapps
INSTALL_PATH=$(ROOT=$ROOTFS webapp-config -li nextcloud $NC_VERSION)
# if the correct version is installed we can skip the installation
if [[ -z "$INSTALL_PATH" ]]
then
	# if not then check if a different version is installed if we need to update it
	INSTALL_PATH=$(ROOT=/build/rootfs/ webapp-config -li nextcloud)
	if [[ ! -z "$INSTALL_PATH" ]]
	then
		ROOT=$ROOTFS webapp-config -U www-apps/nextcloud $NC_VERSION -d nextcloud -s nginx
	else
		ROOT=$ROOTFS webapp-config -I www-apps/nextcloud $NC_VERSION -d nextcloud -s nginx
	fi
fi

set +e
chroot $ROOTFS rc-update add nginx default
chroot $ROOTFS rc-update add php-fpm default
chroot $ROOTFS rc-update add mysql default
chroot $ROOTFS rc-update add redis default
chroot $ROOTFS rc-update add cronie default
chroot $ROOTFS rc-update add syslog-ng default

#echo new cron into cron file
chroot $ROOTFS bash -c 'echo "PATH=/usr/sbin" > mycron'
chroot $ROOTFS bash -c 'echo "*/15 * * * * /bin/su nginx -s /usr/bin/php /var/www/localhost/htdocs/nextcloud/cron.php" >> mycron'
chroot $ROOTFS bash -c 'echo "13 5 * * * /usr/bin/certbot renew --nginx" >> mycron'
#install new cron file
chroot $ROOTFS bash -c 'crontab mycron'
chroot $ROOTFS bash -c 'rm mycron'
set -e
