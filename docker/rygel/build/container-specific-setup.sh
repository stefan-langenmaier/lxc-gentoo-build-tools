#!/bin/bash
set -e
set -x

emerge -uDN --changed-use --with-bdeps=y world -v -j1
eselect news read
emerge --depclean
