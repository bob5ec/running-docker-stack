#!/bin/bash
# exit on first error to break the build
set -e

#set default env to dev
export ENV=${env:-dev}
BUILD_ROOT=`pwd`

echo test samba
cd $BUILD_ROOT/samba/test
./test.sh
echo test backup
cd $BUILD_ROOT/backup/test
./test.sh
