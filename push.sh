#!/bin/bash
source build-system.sh
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/4samba
. push.sh
cd $BUILD_ROOT/backup
. push.sh
cd $BUILD_ROOT/5nextcloud
. push.sh
