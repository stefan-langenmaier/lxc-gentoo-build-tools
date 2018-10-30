#!/bin/bash
set -e
set -x

DATE=`date +%Y-%m`

docker push slangenmaier/gentoo-base-image:$DATE

DATE=`date +%Y-%m-%d`

docker push slangenmaier/nextcloud:$DATE
docker push slangenmaier/kodi:$DATE
docker push slangenmaier/jenkins:$DATE
