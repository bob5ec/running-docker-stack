#!/bin/bash

source build-system.sh
ENV_NEW=$ENV
ENV="new"
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/4samba/test
pull $BUILD_ROOT

cd $BUILD_ROOT/backup/test
pull $BUILD_ROOT

cd $BUILD_ROOT/5nextcloud/test
pull $BUILD_ROOT

ENV=$ENV_NEW
docker image tag bob5ec/samba:new bob5ec/samba:$ENV
docker image tag bob5ec/samba-client:new bob5ec/samba-client:$ENV
docker image tag bob5ec/backup:new bob5ec/backup:$ENV
docker image tag bob5ec/nextcloud:new bob5ec/nextcloud:$ENV
docker image tag bob5ec/nextcloud-client:new bob5ec/nextcloud-client:$ENV

echo docker images after resolve:
docker images
