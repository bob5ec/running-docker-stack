#!/bin/bash

export UID=$UID
export GID=`id -g`
docker-compose -f docker-compose.yml -p backup-test up -d

echo waiting for docker containers to start ...
sleep 3

echo TEST: connect to the test-sshd
docker exec backuptest_backup_1 ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no test@test-sshd -C "echo ... connection OK" || exit 1

echo TEST: run backup
docker exec backuptest_backup_1 /etc/cron.daily/backup.sh || exit 1

echo TEST: backup exists 
#docker exec backuptest_backup_1 /bin/bash -c "[ -f /data2/backup/last/home/1 ]" || exit 1
docker exec backuptest_test-sshd_1 /bin/bash -c "[ -f /home/test/last/home/1 ]" || exit 1
docker exec -it backuptest_backup_1 /bin/bash
#TODO check for all test data
#data/home/exclude.a
#data/home/exclude1
#data/folder
#data/folder/1.exclude
#data/folder/2

#TODO next
#echo TEST: files exist on backup ssh storage
#docker exec backuptest_test-sshd_1 /bin/bash -c "[ -f data/home/1 ]" || exit 1

#docker exec -it backuptest_backup_1 /bin/bash
#docker exec -it backuptest_test-sshd_1 /bin/bash

echo TEST: container comes up
docker ps|grep backuptest_backup_1 || exit 1

echo TEST: cron is running... there is no ps available
docker exec -it backuptest_backup_1 cat /proc/*/status |grep cron || exit 1


docker-compose -f docker-compose.yml -p backup-test down
