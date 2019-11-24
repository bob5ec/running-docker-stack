#!/bin/bash
#set default env to dev
export env=${env:-dev}

cd samba
. push.sh
cd backup
. push.sh
