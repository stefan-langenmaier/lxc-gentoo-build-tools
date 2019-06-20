#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j1
eselect news read
emerge --depclean

if [ -f /.permission-setup ] ; then
	rc-update add jenkins default

	# totally NOT portable
	# to specify here what the mapped docker file will have as a groupid
	groupadd -g 120 outerdocker
	usermod  -a -G 120 jenkins

	rm -f /.permission-setup
fi
