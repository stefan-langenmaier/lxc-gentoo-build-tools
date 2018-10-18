#!/bin/bash
set -e
set -x

docker image prune -f #--filter until=168h*4
