#!/bin/bash

rc-update add sshd default
rc-update add ntp-client default
rc-update add ddclient default

cd /etc/init.d && ln -s net.lo net.eth0
rc-update add net.eth0 boot
