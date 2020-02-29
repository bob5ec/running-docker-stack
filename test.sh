#!/bin/bash
source build-system.sh
BUILD_ROOT=`pwd`

echo test samba
cd $BUILD_ROOT/samba/test
./test.sh
echo test backup
cd $BUILD_ROOT/backup/test
./test.sh
echo test nextcloud
cd $BUILD_ROOT/nextcloud/test
./test.sh
