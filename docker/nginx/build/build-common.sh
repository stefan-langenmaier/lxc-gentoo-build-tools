#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"

DATE=`date +%Y-%m-%d`
BINAME="slangenmaier/common-builder:latest"

BNAME=nginx-builder-instance
INAME=slangenmaier/nginx-slim
ROOTFS=/mnt/full-data/vols/common-builder/nginx/
if [[ -z "$JOB_BASE_NAME" ]]; then
	PC_ROOT=$(realpath ../portage-configroot/)
else
	PC_ROOT_SUFFIX=$(realpath ../portage-configroot/)
	PC_ROOT_SUFFIX=${PC_ROOT_SUFFIX#"/var/lib/jenkins/home/workspace/$JOB_BASE_NAME/"}
	PC_ROOT=/mnt/full-data/vols/jenkins-home/workspace/${JOB_BASE_NAME}/${PC_ROOT_SUFFIX}
fi

OLD_IMAGE=$(docker ps --filter=name="${BNAME}" --format '{{.Image}}')
OLD_IMAGE_ID=$(docker images --filter=reference="${OLD_IMAGE}" --format '{{.ID}}')

NEW_IMAGE_ID=$(docker images --filter=reference="${BINAME}" --format '{{.ID}}')

if [[ $(docker ps -a --filter "name=^/$BNAME$" --format '{{.Names}}') != '' && $NEW_IMAGE_ID != $OLD_IMAGE_ID ]]
then
    	docker rm "${BNAME}"
fi

if [[ $(docker ps -a --filter "name=^/$BNAME$" --format '{{.Names}}') != $BNAME ]]
then
    	docker run \
                --cap-add SYS_PTRACE \
                --tmpfs /run \
                -v /usr/portage:/usr/portage:ro \
                -v /usr/portage/distfiles:/usr/portage/distfiles:rw \
                -v /mnt/full-data/vols/cuboxi-packages/:/usr/portage/packages:rw \
                -v ${ROOTFS}:/build/rootfs:rw \
                -v ${PC_ROOT}:/build/portage-configroot:ro \
                -v /mnt/full-data/vols/container-profiles:/usr/local/portage/container-profiles:ro \
                 --name $BNAME \
		-d \
                "${BINAME}" \
                        /sbin/init
else
    	docker start $BNAME
fi

docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ $BNAME bash -c "emerge -uDN @system @container_set @world"
docker exec -e ROOT=/build/rootfs/ -e PORTAGE_CONFIGROOT=/build/portage-configroot/ $BNAME bash -c "emerge --depclean"

docker cp $(realpath ../..//gentoo-container-image/build/etc/inittab) $BNAME:/build/rootfs/etc/inittab
set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'echo "rc_provide=\"net\"" >> ${ROOTFS}/etc/rc.conf'
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

set +e
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} rc-update add nginx default'
# currently no user is created in the ROOTFS
docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'chroot ${ROOTFS} useradd nginx'
set -e

docker exec -e ROOTFS=/build/rootfs $BNAME bash -c 'cd ${ROOTFS} ; tar -c .' | docker import - ${INAME}
docker tag "${INAME}:latest" "${INAME}:${DATE}"

docker stop $BNAME
