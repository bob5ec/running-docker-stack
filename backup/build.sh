#!/bin/bash
source ../build-system.sh

docker build -t bob5ec/backup:$env .
