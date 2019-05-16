#!/bin/bash
docker-compose -f docker-compose.yml -p backup-test up -d

sleep 5

echo TEST: container comes up
docker ps|grep backuptest_backup_1 || exit 1

echo TEST: cron is running... there is no ps available
docker exec -it backuptest_backup_1 cat /proc/*/status |grep cron || exit 1

#docker exec -it backuptest_backup_1 /bin/bash

docker-compose -f docker-compose.yml -p backup-test down
