#!/bin/bash
docker-compose -f docker-compose.yml -p backup-test up -d

# container comes up
docker ps|grep backuptest_backup_1 || exit 1
#  - docker exec backup ps aux|grep cron
#docker exec -it backuptest_backup_1 /bin/bash

docker-compose -f docker-compose.yml -p backup-test down
