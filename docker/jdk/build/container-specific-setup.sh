#!/bin/bash
set -e
set -x

emerge -uDN --changed-use --with-bdeps=y --binpkg-changed-deps=y world -j4 --load-average 4 --autounmask
eselect news read
emerge --depclean
