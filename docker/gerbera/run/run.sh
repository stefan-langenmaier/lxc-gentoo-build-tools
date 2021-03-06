#!/bin/bash
set -e
set -x

docker run -it \
	--net host \
	--privileged \
	--rm \
	-d \
	-v /mnt/full-data/vols/gerbera:/var/lib/gerbera:rw \
	-v /mnt/full-data/vols/cuboxi-packages:/usr/portage/packages:rw \
	-v /mnt/full-data/vols/music:/data/music:ro \
	-v /mnt/full-data/vols/tv:/data/tv:ro \
	-v /mnt/full-data/vols/audiobooks:/data/audiobooks:ro \
	--name "gerbera" \
	"slangenmaier/gerbera:latest" \
		/sbin/init
