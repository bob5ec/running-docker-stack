#!/bin/bash

source build-system.sh
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/samba
. build.sh

cd $BUILD_ROOT/backup
. build.sh

cd $BUILD_ROOT/nextcloud/test
. build.sh
