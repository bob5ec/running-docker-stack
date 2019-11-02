#!/bin/bash
BUILD_ROOT=`pwd`
cd $BUILD_ROOT/samba
. build.sh

cd $BUILD_ROOT/backup
. build.sh
