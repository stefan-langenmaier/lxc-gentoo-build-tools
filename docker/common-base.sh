#!/bin/bash

#cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`
BINAME="slangenmaier/common-builder:latest"

if [ -z "$JOB_BASE_NAME" ]; then
	PC_ROOT=$(realpath ../portage-configroot/)
else
	PC_ROOT_SUFFIX=$(realpath ../portage-configroot/)
	PC_ROOT_SUFFIX=${PC_ROOT_SUFFIX#"/var/lib/jenkins/home/workspace/$JOB_BASE_NAME/"}
	PC_ROOT=/mnt/full-data/vols/jenkins-home/workspace/${JOB_BASE_NAME}/${PC_ROOT_SUFFIX}
fi

if [ -d "../portage-host" ]; then
	if [ -z "$JOB_BASE_NAME" ]; then
		PH_ROOT=$(realpath ../portage-host/)
	else
		PH_ROOT_SUFFIX=$(realpath ../portage-host/)
		PH_ROOT_SUFFIX=${PH_ROOT_SUFFIX#"/var/lib/jenkins/home/workspace/$JOB_BASE_NAME/"}
		PH_ROOT=/mnt/full-data/vols/jenkins-home/workspace/${JOB_BASE_NAME}/${PH_ROOT_SUFFIX}
	fi
fi

function start_builder_container() {
OLD_IMAGE=$(docker ps -a --filter=name="${BNAME}" --format '{{.Image}}')
OLD_IMAGE_ID=$(docker images --filter=reference="${OLD_IMAGE}" --format '{{.ID}}')

NEW_IMAGE_ID=$(docker images --filter=reference="${BINAME}" --format '{{.ID}}')

if [[ $(docker ps -a --filter "name=^/$BNAME$" --format '{{.Names}}') != '' && $NEW_IMAGE_ID != $OLD_IMAGE_ID ]]
then
    	docker rm -f "${BNAME}"
fi

if [[ $(docker ps -a --filter "name=^/$BNAME$" --format '{{.Names}}') != $BNAME ]]
then
        [[ ! -z ${PH_ROOT} ]] && PH_ROOT_LINE="-v ${PH_ROOT}:/etc/portage:rw"
        [[ ! -z ${CONTAINER_MOUNT} ]] && CONTAINER_MOUNT_LINE="--cap-add SYS_ADMIN"
    	docker run \
		${CONTAINER_MOUNT_LINE} \
                --cap-add SYS_PTRACE \
                --tmpfs /run \
		--stop-signal SIGPWR \
                -v /usr/portage:/usr/portage:ro \
                -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
                -v /mnt/full-data/vols/cuboxi-packages/:/usr/portage/packages:rw \
		-v ${ROOTFS}:/build/rootfs:rw \
		-v ${PC_ROOT}:/build/portage-configroot:rw \
		${PH_ROOT_LINE} \
		-v /mnt/full-data/vols/container-profiles:/usr/local/portage/container-profiles:ro \
		--name $BNAME \
		-d \
                "${BINAME}" \
                        /sbin/init
else
    	docker start $BNAME
fi

}

function install_base_system() {
SYSROOT=${SYSROOT:-/}
docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ -e SYSROOT=/ $BNAME bash -c "emerge -uDN @system @container_set @world --autounmask=y"
if [[ "$SYSROOT" != "/" ]] ; then
	docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ -e SYSROOT=$SYSROOT $BNAME bash -c "emerge -uDN @system @container_set @world --autounmask=y --with-bdeps=y"
fi
docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ $BNAME bash -c "emerge --depclean"

docker cp $(realpath ../../common-builder/build/etc/inittab) $BNAME:/build/rootfs/etc/inittab
docker cp $(realpath ../../common-builder/build/etc/sysctl.conf) $BNAME:/build/rootfs/etc/sysctl.conf
docker cp $(realpath ../../common-builder/build/etc/nsswitch.conf) $BNAME:/build/rootfs/etc/nsswitch.conf
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'mkdir -p ${ROOTFS}/etc/portage'
docker cp $(realpath ../../common-builder/build/etc/portage/make.conf) $BNAME:/build/rootfs/etc/portage/make.conf

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'echo "en_US.UTF-8 UTF-8" > ${ROOTFS}/etc/locale.gen && chroot ${ROOTFS} locale-gen'

set +e
# todo also for ttys and rc_sys
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'grep -q "^rc_provide=" ${ROOTFS}/etc/rc.conf && sed -i "s/^rc_provide.*/rc_provide=\"net net.lo lo\"/" ${ROOTFS}/etc/rc.conf || echo "rc_provide=\"net net.lo lo\"" >> ${ROOTFS}/etc/rc.conf'
#docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'echo "rc_provide=\"net\"" >> ${ROOTFS}/etc/rc.conf'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add cgroups sysinit'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del devfs sysinit'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del dmesg sysinit'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del fsck boot'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del hostname boot'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del hwclock boot'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del keymaps boot'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del loopback boot'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del modules boot'
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update del sysctl boot'
set -e
}

function create_image() {
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'cd ${ROOTFS} ; tar -c .' | docker import - ${INAME}
docker tag "${INAME}:latest" "${INAME}:${DATE}"
}

function stop_container() {
docker stop $BNAME
}
