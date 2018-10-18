#!/bin/bash
set -e
set -x

docker export cubox-i-builder | xz > /autodeploy-exchange/cuboxi.tar.xz

