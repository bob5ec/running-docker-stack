#!/bin/bash
source ../build-system.sh

docker build -t bob5ec/samba:$env .

# build test container
cd test
. build.sh
