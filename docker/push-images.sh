#!/bin/bash
set -x

DATE_M=`date +%Y-%m`
DATE_D="${DATE_M}-01"

docker push slangenmaier/common-builder:$DATE_D

docker push slangenmaier/nextcloud:$DATE_D
docker push slangenmaier/kodi:$DATE_D
docker push slangenmaier/backup:$DATE_D
docker push slangenmaier/jenkins:$DATE_D
docker push slangenmaier/monitoring-agent:$DATE_D
docker push slangenmaier/monitoring:$DATE_D
docker push slangenmaier/gerbera:$DATE_D
