#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j4 --load-average 4

rc-update add cronie default
rc-update add dbus default
