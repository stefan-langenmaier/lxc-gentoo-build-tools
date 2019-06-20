#!/bin/bash

# necessary packages
emerge -uDN --changed-use --with-bdeps=y world -j4 --load-average 4

# u-boot
#git clone https://github.com/u-boot/u-boot /root/u-boot

# autodeploy
#git clone https://github.com/stefan-langenmaier/cubox-i-autodeploy-image /root/cubox-i-autodeploy-image
