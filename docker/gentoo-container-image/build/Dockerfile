FROM slangenmaier/gentoo-base-image:latest
ADD etc/sysctl.conf /etc/sysctl.conf
RUN rc-update del udev sysinit && rc-update del udev-trigger sysinit && rc-update del loopback boot
RUN sed -i 's/#rc_provide=.*$/rc_provide="net"/g' /etc/rc.conf 
#RUN sed -i 's/\tcgroup_add_service/\t#cgroup_add_service/g' /lib/rc/sh/openrc-run.sh
STOPSIGNAL SIGPWR
ADD etc/inittab /etc/inittab

#RUN true &&\
#    sed -i 's/#rc_controller_cgroups=.*$/rc_controller_cgroups="NO"/g' /etc/rc.conf &&\
#    sed -i 's/#rc_depend_strict=.*$/rc_depend_strict="NO"/g' /etc/rc.conf &&\
#    sed -i 's/#rc_need=.*$/rc_need="!net !devfs !loopback !modules-load !kmod-static-nodes !opentmpfiles-dev !opentmpfiles-setup !dev !udev-mount !sysfs !checkfs !fsck !netmount !logger !clock !modules"/g' /etc/rc.conf &&\
#    sed -i 's/#rc_provide=.*$/rc_provide="net net.lo devfs loopback modules-load kmod-static-nodes opentmpfiles-dev opentmpfiles-setup dev udev-mount sysfs checkfs fsck netmount logger clock modules"/g' /etc/rc.conf &&\
# Tell openrc its running inside a container, till now that has meant LXC
#    sed -i 's/#rc_sys=""/rc_sys="docker"/g' /etc/rc.conf 

#&&\
# Tell openrc loopback and net are already there, since docker handles the networking
#    echo 'rc_provide="loopback net"' >> /etc/rc.conf &&\
# no need for loggers
#    sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf 
# &&\
# can't get ttys unless you run the container in privileged mode
#    sed -i '/tty/d' /etc/inittab &&\
# can't set hostname since docker sets it
#    sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname &&\
# can't mount tmpfs since not privileged
#    sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh &&\
# can't do cgroups
#    sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh

#rc_controller_cgroups="NO"
#rc_depend_strict="NO"
#rc_need="!net !dev !udev-mount !sysfs !checkfs !fsck !netmount !logger !clock !modules"
