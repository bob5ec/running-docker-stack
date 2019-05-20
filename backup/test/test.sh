#!/bin/bash
docker-compose -f docker-compose.yml -p backup-test up -d

echo waiting for docker containers to start ...
sleep 3

echo TEST: connect to the test-sshd
docker exec -it backuptest_backup_1 ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no test@test-sshd -C "echo ... connection OK" || exit 1

#docker exec -it backuptest_backup_1 /bin/bash
#docker exec -it backuptest_test-sshd_1 /bin/bash

echo TEST: container comes up
docker ps|grep backuptest_backup_1 || exit 1

echo TEST: cron is running... there is no ps available
docker exec -it backuptest_backup_1 cat /proc/*/status |grep cron || exit 1


docker-compose -f docker-compose.yml -p backup-test down
