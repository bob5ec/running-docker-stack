#!/bin/bash

SSH_HOST=test@test-sshd
# all backups are stored in this directory
BASE_DIR=/home/test

[ -f /root/backup.conf ] source /root/backup.conf

TODAY=`date +%F_%H-%M`
 
ssh $SSH_HOST -C mkdir -p $BASE_DIR/$TODAY

rsync -v -a --link-dest=$SSH_HOST:$BASE_DIR/last --exclude-from '/root/backup.excludelist' `cat /root/backup.list` $SSH_HOST:$BASE_DIR/$TODAY || exit 1

# mark current backup as the last one
ssh $SSH_HOST -C ln -s -f $BASE_DIR/$TODAY $BASE_DIR/last
