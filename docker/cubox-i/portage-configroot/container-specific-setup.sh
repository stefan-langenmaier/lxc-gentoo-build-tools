#!bin/bash

ROOTFS=/build/rootfs

grep -q "^rc_provide=" ${ROOTFS}/etc/rc.conf && sed -i "s/^rc_provide.*/rc_provide=\"\"/" ${ROOTFS}/etc/rc.conf || echo "rc_provide=\"\"" >> ${ROOTFS}/etc/rc.conf

chroot ${ROOTFS} rc-update add devfs sysinit
chroot ${ROOTFS} rc-update add dmesg sysinit
chroot ${ROOTFS} rc-update add fsck boot
chroot ${ROOTFS} rc-update add hostname boot
chroot ${ROOTFS} rc-update add hwclock boot
chroot ${ROOTFS} rc-update add keymaps boot
chroot ${ROOTFS} rc-update add loopback boot
chroot ${ROOTFS} rc-update add modules boot
chroot ${ROOTFS} rc-update add sysctl boot

chroot ${ROOTFS} rc-update add sshd default
chroot ${ROOTFS} rc-update add ddclient default
chroot ${ROOTFS} rc-update add docker default
chroot ${ROOTFS} rc-update add ntp-client default

rm ${ROOTFS}/.dockerenv

cp /build/portage-configroot/etc/gshadow* ${ROOTFS}/etc/
cp /build/portage-configroot/etc/shadow* ${ROOTFS}/etc/
cp /build/portage-configroot/etc/passwd* ${ROOTFS}/etc/
cp /build/portage-configroot/etc/group* ${ROOTFS}/etc/

cp /build/portage-configroot/etc/inittab ${ROOTFS}/etc/
