#!/bin/bash

emerge -uDN world -j1

rc-update add jenkins default

# totally NOT portable
# to specify here what the mapped docker file will have as a groupid
groupadd -g 120 outerdocker
usermod  -a -G 120 jenkins
