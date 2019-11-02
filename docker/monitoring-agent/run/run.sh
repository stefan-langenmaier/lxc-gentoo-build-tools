#!/bin/bash
set -e
set -x

docker run \
	--tmpfs /run \
	--rm \
	--cap-add=SYS_RAWIO \
	--cap-add=SYS_PTRACE \
	--device /dev/sda:/dev/sda:r \
	--network host \
	-d \
	-v /usr/portage:/usr/portage:ro \
	-v /mnt/full-data/vols/monitoring-agent-config/collectd/collectd.conf:/etc/collectd.conf:rw \
	--name "monitoring-agent" \
	"slangenmaier/monitoring-agent:latest" \
		/sbin/init
