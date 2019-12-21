#!/bin/bash
#set default env to dev
export env=$TRAVIS_BRANCH
export env=${env:-dev}
BUILD_ROOT=`pwd`

cd $BUILD_ROOT/samba
. build.sh

cd $BUILD_ROOT/backup
. build.sh
