#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	-v /usr/portage:/usr/portage:ro \
	-v /usr/portage/distfiles:/usr/portage/distfiles:rw \
	-v /mnt/full-data/vols/quake3:/var/lib/quake3/.q3a:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-p 27960:27960/udp \
	--name "quake3" \
	"slangenmaier/quake3:latest" \
		su -l quake3 -s /bin/bash -c 'ioq3ded +exec levels.cfg'
