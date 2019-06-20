#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j4 --load-average 4
