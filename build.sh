#!/bin/bash
BUILD_ROOT=`pwd`
cd $BUILD_ROOT/samba
. build.sh

cd $BUILDROOT/backup
. build.sh
