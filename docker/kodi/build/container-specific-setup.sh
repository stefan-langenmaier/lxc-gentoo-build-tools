#!/bin/bash

emerge -uDN world --changed-use --with-bdeps=y -j4 --load-average 4
