#!/bin/bash
BUILD_ROOT=`pwd`
cd $BUILD_ROOT/samba/test
. test.sh
cd $BUILD_ROOT/backup/test
. test.sh
