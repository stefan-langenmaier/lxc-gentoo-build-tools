#!/bin/bash
set -e
set -x

docker run \
	--rm \
	-d \
	--name "openvpn" \
	"slangenmaier/openvpn:latest" \
		/sbin/init
