#!/bin/bash
set -e
set -x

emerge -u gentoo-sources
emerge --depclean
eselect kernel set 1
cp /kernel-config /usr/src/linux/.config
cd /usr/src/linux
make oldconfig
make -j2
make dtbs
