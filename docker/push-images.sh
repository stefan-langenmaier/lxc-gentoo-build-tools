#!/bin/bash
set -e
set -x

DATE_M=`date +%Y-%m`
DATE_D="${DATE_M}-01"

docker push slangenmaier/gentoo-base-image:$DATE_M

docker push slangenmaier/nextcloud:$DATE_D
docker push slangenmaier/kodi:$DATE_D
docker push slangenmaier/backup:$DATE_D
docker push slangenmaier/jenkins:$DATE_D
