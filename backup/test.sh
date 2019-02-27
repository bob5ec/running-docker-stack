#!/bin/bash
docker-compose -f test.yml -p backup-test up -d
docker exec -it backuptest_backup_1 /bin/bash
docker-compose -f test.yml -p backup-test down
