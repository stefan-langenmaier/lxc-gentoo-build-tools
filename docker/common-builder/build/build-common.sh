#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=common-builder-builder-instance
INAME=slangenmaier/common-builder
ROOTFS=/mnt/full-data/vols/common-builder/common-builder/

start_builder_container

install_base_system

set +e
set -e

create_image

stop_container
