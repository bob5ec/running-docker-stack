#!/bin/bash

SSH_HOST=test@test-sshd
# all backups are stored in this directory
BASE_DIR=/home/test

[ -f /root/backup.conf ] && source /root/backup.conf

TODAY=`date +%F_%H-%M`
 
#ssh $SSH_HOST -C mkdir -p $BASE_DIR/$TODAY

rsync -v -a --link-dest=../last --exclude-from '/root/backup.excludelist' `cat /root/backup.list` $SSH_HOST:$BASE_DIR/$TODAY || exit 1

# mark current backup as the last one
TMPDIR=`mktemp -d`

# rm $BASE_DIR/last
rsync -v -a --remove-source-files $SSH_HOST:$BASE_DIR/last $TMPDIR/old

ln -s $BASE_DIR/$TODAY $TMPDIR/last
rsync -v -a  $TMPDIR/last $SSH_HOST:$BASE_DIR/last || exit 1
rm -r $TMPDIR
