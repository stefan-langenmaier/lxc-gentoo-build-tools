#!/bin/bash
set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m`

docker build . -t "slangenmaier/gentoo-container-image:latest"

docker tag "slangenmaier/gentoo-container-image:latest" "slangenmaier/gentoo-container-image:${DATE}"
