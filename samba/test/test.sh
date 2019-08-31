#!/bin/bash

export UID=$UID
export GID=`id -g`
#use original compose and add client
docker-compose -f ../../samba.yml -f samba.override.yml -p samba-test up -d

echo waiting for docker containers to start ...
sleep 3

echo TEST: container comes up
docker ps|grep samba || exit 1

# TODO add cron when migration to feature branches and deploy gatekeeper is done
#echo TEST: cron is running... there is no ps available
#docker exec -it backuptest_backup_1 cat /proc/*/status |grep cron || exit 1

#echo TEST: connect to the test-sshd
#docker exec backuptest_backup_1 ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no test@test-sshd -C "echo ... connection OK" || exit 1

# TEST case with existing last link
#docker exec backuptest_test-sshd_1 /bin/bash -c "ln -s /tmp /home/test/last" || exit 1

# create target folder
#BASE_DIR=/home/test/backup
#docker exec backuptest_test-sshd_1 /bin/bash -c "mkdir -p $BASE_DIR; chown test $BASE_DIR"

#echo TEST: run backup
#docker exec backuptest_backup_1 /etc/cron.daily/backup.sh || exit 1

#echo TEST: backup exists on storage
#BASE_DIR=/home/test/backup
#docker exec backuptest_test-sshd_1 /bin/bash -c "[ -f $BASE_DIR/last/home/1 ] && [ ! -f $BASE_DIR/last/home/exclude1 ] && [ ! -f $BASE_DIR/last/home/exclude.a ] && [ -f $BASE_DIR/last/folder/2 ] && [ ! -f $BASE_DIR/last/folder/1.exclude ]" || exit 1

# do we really need an extra mirror??? -> remove it if not needed
#echo TEST: run mirror
#docker exec backuptest_backup_1 /etc/cron.daily/mirror.sh || exit 1
#
#echo TEST: mirror exists on storage
#BASE_DIR=/home/test/backup
#docker exec backuptest_test-sshd_1 /bin/bash -c "[ -f $BASE_DIR/last/home/1 ] && [ ! -f $BASE_DIR/last/home/exclude1 ] && [ ! -f $BASE_DIR/last/home/exclude.a ] && [ -f $BASE_DIR/last/folder/2 ] && [ ! -f $BASE_DIR/last/folder/1.exclude ]" || exit 1

#DEBUG
#docker exec -it backuptest_backup_1 /bin/bash
#docker exec -it backuptest_test-sshd_1 /bin/bash


docker-compose -f ../../samba.yml -f samba.override.yml -p samba-test down
