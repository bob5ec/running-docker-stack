#!/bin/bash
docker image tag bob5ec/backup:new bob5ec/backup:$env
# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/backup:$env
docker logout
