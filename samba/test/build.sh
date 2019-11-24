#!/bin/bash
#set default env to dev
export env=${env:-dev}

docker build -t bob5ec/samba-client:$env .
