#!/bin/bash
docker-compose -f docker-compose.yml -p backup-test up -d
#docker exec -it backuptest_backup_1 /bin/bash
docker-compose -f docker-compose.yml -p backup-test down
