#!/bin/bash
SSH_HOST=test@test-sshd
# all backups are stored in this directory
BASE_DIR=/home/test

[ -f /root/mirror.conf ] && source /root/mirror.conf

ssh $SSH_HOST -C mkdir -p $BASE_DIR

rsync -v -a --exclude-from '/root/mirror.excludelist' `cat /root/mirror.list` $SSH_HOST:$BASE_DIR || exit 1
