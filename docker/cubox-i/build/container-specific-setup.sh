#!/bin/bash

emerge -uDN --changed-use --binpkg-respect-use=y --binpkg-changed-deps=y --with-bdeps=y world -j4 --load-average 4
