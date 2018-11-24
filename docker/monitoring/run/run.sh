#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	--tmpfs /run \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/monitoring-config/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:rw \
	-v /mnt/full-data/vols/monitoring-config/collectd/collectd.conf:/etc/collectd.conf:rw \
	-v /mnt/full-data/vols/monitoring-data:/var/lib/prometheus/data:rw \
	-p 9191:9090 \
	-p 3000:3000 \
	--entrypoint="/sbin/init" \
	--name "monitoring" \
		"slangenmaier/monitoring:latest"