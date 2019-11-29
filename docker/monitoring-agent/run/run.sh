#!/bin/bash
set -e
set -x

ADDED_DEVICES=""
for d in /dev/sd? ; do ADDED_DEVICES="${ADDED_DEVICES} --device ${d}:${d}:r" ; done
echo $ADDED_DEVICES

docker run \
	--tmpfs /run \
	--rm \
	--cap-add=SYS_RAWIO \
	--cap-add=SYS_PTRACE \
	$ADDED_DEVICES \
	--network host \
	-d \
	-v /usr/portage:/usr/portage:ro \
	-v /mnt/full-data/vols/monitoring-agent-config/collectd/collectd.conf:/etc/collectd.conf:rw \
	--name "monitoring-agent" \
	"slangenmaier/monitoring-agent:latest" \
		/sbin/init
