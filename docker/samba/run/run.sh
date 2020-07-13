#!/bin/bash
set -e
set -x

docker run \
	--rm \
        -p 139:139 \
        -p 445:445 \
	--tmpfs /run \
	-d \
	-v /mnt/full-data/vols/samba-config/smb.conf:/etc/samba/smb.conf:rw \
	-v /mnt/full-data/vols/scans/:/mnt/scans/:rw \
	--name "samba" \
	"slangenmaier/samba:latest" \
		/sbin/init
