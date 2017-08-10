#!/bin/bash

wget -q -O - "https://github.com/stefan-langenmaier/lxc-gentoo-build-tools/releases/download/v0.1/gentoo-base-container.xz" | unxz | btrfs receive /mnt/full-root/vols/

