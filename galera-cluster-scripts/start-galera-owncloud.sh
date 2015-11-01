mount -o subvol=vols/galera-owncloud /dev/mmcblk0p3  /vols/galera-owncloud/
mount -o subvol=galera-data-owncloud /dev/mapper/data-01  /data/galera-data-owncloud/
lxc-start -n galera-cluster -P /vols/galera-owncloud/
