#!/bin/bash
set -e
set -x

emerge -uDN --changed-use --with-bdeps=y world -j4 --load-average 4
eselect news read
emerge --depclean
