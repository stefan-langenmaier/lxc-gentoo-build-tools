#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-it \
	-v /mnt/full-data/vols/redmine-data:/usr/src/redmine/files:rw \
	-v /mnt/full-data/vols/redmine-db/production.db:/usr/src/redmine/sqlite/redmine.db:rw \
	-p 4000:3000 \
	--name "redmine" \
	"redmine:4.0"
