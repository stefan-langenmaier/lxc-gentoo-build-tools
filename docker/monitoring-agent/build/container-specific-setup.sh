#!/bin/bash

emerge -uDN world --changed-use --with-bdeps=y
rc-update add collectd default
usermod -a -G disk collectd
touch /var/log/collectd.conf
chown collectd:collectd /var/log/collectd.conf
