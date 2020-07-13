#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	--tmpfs /run \
	-v /mnt/full-data/vols/monitoring-config/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:rw \
	-v /mnt/full-data/vols/monitoring-config/prometheus/alerts.yml:/etc/prometheus/alerts.yml:rw \
	-v /mnt/full-data/vols/monitoring-config/alertmanager/config.yml:/etc/alertmanager/config.yml:rw \
	-v /mnt/full-data/vols/monitoring-config/collectd/collectd.conf:/etc/collectd.conf:rw \
	-v /mnt/full-data/vols/monitoring-config/create-ssh-tunnels.start:/etc/local.d/create-ssh-tunnels.start:rw \
	-v /mnt/full-data/vols/monitoring-config/ssh:/root/.ssh:rw \
	-v /mnt/full-data/vols/monitoring-data:/var/lib/prometheus/data:rw \
	-p 9191:9090 \
	-p 3000:3000 \
	--entrypoint="/sbin/init" \
	--name "monitoring" \
		"slangenmaier/monitoring:latest"
