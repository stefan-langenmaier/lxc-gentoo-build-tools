#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j4 --load-average 4

rc-update add prometheus default
rc-update add alertmanager default
rc-update add collectd default
