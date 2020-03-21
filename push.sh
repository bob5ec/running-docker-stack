#!/bin/bash
source build-system.sh
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/samba
. push.sh
cd $BUILD_ROOT/backup
. push.sh
cd $BUILD_ROOT/nextcloud/test
. push.sh
