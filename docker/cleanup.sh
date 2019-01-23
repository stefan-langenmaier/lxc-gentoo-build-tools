#!/bin/bash
set -e
set -x

docker image prune -f # all dangling
docker image prune -f --all --filter until=768h # 32d

# removes all stopped containers of a certain age
docker container prune -f --filter until=168h #7d
