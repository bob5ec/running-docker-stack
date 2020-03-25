#!/bin/bash
source ../build-system.sh

docker build -t bob5ec/nextcloud:new .

cd test
. build.sh
