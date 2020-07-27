#!/bin/bash

source build-system.sh
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/4samba
. build.sh

cd $BUILD_ROOT/backup
. build.sh

cd $BUILD_ROOT/5nextcloud
. build.sh

echo docker images:
docker images
