#!/bin/bash

eselect news read
#emerge -uDN world --changed-use --with-bdeps=y -j4 --load-average 4 --binpkg-respect-use=y --binpkg-changed-deps=y
emerge -e world -j4 --load-average 4
#emerge @preserved-rebuild
#perl-cleaner --all
emerge --depclean
eselect news read

