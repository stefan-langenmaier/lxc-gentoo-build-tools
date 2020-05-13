#!/bin/bash
set -e
set -x

mkdir -p /mnt/full-data/common-builder/autodeploy-exchange
docker export cubox-i-builder | xz --threads=0 > /mnt/full-data/common-builder/autodeploy-exchange/cubox-i.tar.xz

