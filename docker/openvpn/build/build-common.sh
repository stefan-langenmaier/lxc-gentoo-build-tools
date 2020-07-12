#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"
. ../../common-base.sh

BNAME=openvpn-builder-instance
INAME=slangenmaier/openvpn
ROOTFS=/mnt/full-data/vols/common-builder/openvpn/

start_builder_container

install_base_system

set +e
set -e

create_image

stop_container
