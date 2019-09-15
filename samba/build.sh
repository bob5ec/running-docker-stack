#!/bin/bash
docker build -t bob5ec/samba:latest .

# build test container
cd test
. build.sh
