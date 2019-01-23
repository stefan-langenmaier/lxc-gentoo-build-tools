#!/bin/bash

eselect news read
emerge -uDN world --with-bdeps=y -j1
emerge @preserved-rebuild
perl-cleaner --all
emerge --depclean
eselect news read
