#!/bin/bash
docker build -t bob5ec/backup:latest .
docker run -d --name backup bob5ec/backup:latest
docker ps|grep backup
#  - docker exec backup ps aux|grep cron
docker stop backup

# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/backup:latest
docker logout
