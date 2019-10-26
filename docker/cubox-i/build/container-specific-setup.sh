#!/bin/bash

emerge -uDN --changed-use --binpkg-respect-use=y --with-bdeps=y world -j4 --load-average 4
