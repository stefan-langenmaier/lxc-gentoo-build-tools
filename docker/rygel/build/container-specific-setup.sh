#!/bin/bash
set -e
set -x

emerge -uDN world -v -j1
eselect news read
emerge --depclean
