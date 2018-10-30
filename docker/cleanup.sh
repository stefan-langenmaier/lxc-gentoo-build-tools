#!/bin/bash
set -e
set -x

docker image prune -f --filter until=768h # 31d
