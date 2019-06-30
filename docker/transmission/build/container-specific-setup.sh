#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j1
eselect news read
emerge --depclean

rc-update add transmission-daemon default
