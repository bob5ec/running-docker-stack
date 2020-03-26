#!/bin/bash
source ../build-system.sh

#docker image tag bob5ec/backup:new bob5ec/backup:$ENV
# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/backup:$ENV
docker logout
