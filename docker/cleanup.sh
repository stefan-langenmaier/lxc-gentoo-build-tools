#!/bin/bash
set -e
set -x

docker image prune -f # all dangling
docker image prune -f --all --filter until=768h # 31d

docker container prune -f
