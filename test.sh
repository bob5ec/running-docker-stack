#!/bin/bash
source build-system.sh
BUILD_ROOT=`pwd`

echo test samba:$ENV
cd $BUILD_ROOT/4samba/test
./test.sh
echo test backup:$ENV
cd $BUILD_ROOT/backup/test
./test.sh
echo test nextcloud:$ENV
cd $BUILD_ROOT/5nextcloud/test
./test.sh
