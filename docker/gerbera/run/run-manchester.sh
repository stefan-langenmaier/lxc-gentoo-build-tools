#!/bin/bash
set -e
set -x

docker run -it \
	--net host \
	--privileged \
	--rm \
	-d \
	-v /mnt/full-data/vols/gerbera:/var/lib/gerbera:rw \
	-v /mnt/full-data/vols/nextcloud-data/christina.langenmaier/files/Music/:/data/music-christina:ro \
	--name "gerbera" \
	"slangenmaier/gerbera:latest" \
		/sbin/init
