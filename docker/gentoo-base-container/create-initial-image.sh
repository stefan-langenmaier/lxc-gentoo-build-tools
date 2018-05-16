#!/bin/bash

cd /var/lib/lxc/gentoo-base-container/rootfs

DATE=`date +%Y-%m-%d`
tar -c . | docker import - "stefan-langenmaier/gentoo-base-container:${DATE}"
