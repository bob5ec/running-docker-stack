#!/bin/bash

source build-system.sh
ENV_NEW=$ENV
ENV="new"
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/samba/test
pull $BUILD_ROOT/samba.yml

cd $BUILD_ROOT/backup/test
pull $BUILD_ROOT/samba.yml

cd $BUILD_ROOT/nextcloud/test
pull $BUILD_ROOT/nextcloud.yml

ENV=$ENV_NEW
docker image tag bob5ec/samba:new bob5ec/samba:$ENV
docker image tag bob5ec/samba-client:new bob5ec/samba-client:$ENV
docker image tag bob5ec/backup:new bob5ec/backup:$ENV
docker image tag bob5ec/nextcloud:new bob5ec/nextcloud:$ENV
docker image tag bob5ec/nextcloud-client:new bob5ec/nextcloud-client:$ENV

echo docker images after resolve:
docker images
