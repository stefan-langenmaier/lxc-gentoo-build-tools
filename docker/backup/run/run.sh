#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	--privileged \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/backup-config/snapper-configs:/etc/snapper/configs:rw \
	-v /mnt/full-data/vols/backup-config/snapper.conf:/etc/conf.d/snapper:rw \
	-v /mnt/full-data/vols/backup-config/backup-up-log.de.sh:/etc/cron.daily/backup-up-log.de.sh:rw \
	-v /mnt/full-data/vols/backup-config/id_rsa:/root/.ssh/id_rsa:ro \
	-v /mnt/full-data/vols/backup-config/known_hosts:/root/.ssh/known_hosts:rw \
	-v /mnt/full-data:/mnt/full-data:rw \
	-v /mnt/full-root:/mnt/full-root:rw \
	--entrypoint="/sbin/init" \
	--name "backup" \
		"slangenmaier/backup:latest"
