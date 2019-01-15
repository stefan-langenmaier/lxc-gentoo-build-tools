#!/bin/bash

emerge -uDN world --with-bdeps=y -j1
emerge @preserved-rebuild
perl-cleaner --all
emerge --depclean
