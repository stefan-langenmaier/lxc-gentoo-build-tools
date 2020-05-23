#!/bin/bash

set -x
set -e

# hobo transfer
docker container rm -f transfer-container cubox-i || echo "was already removed"
docker run -d --rm --name transfer-container -v autodeploy-exchange:/autodeploy-exchange slangenmaier/common-builder /sbin/init
docker container create --name cubox-i slangenmaier/cubox-i:latest /bin/true
docker export cubox-i | xz --threads=0 --stdout | docker exec -i transfer-container bash -c "cat - > /autodeploy-exchange/cubox-i.tar.xz"
docker container rm -f transfer-container cubox-i
