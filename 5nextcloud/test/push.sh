#!/bin/bash
source ../../build-system.sh

#docker image tag bob5ec/nextcloud-client:new bob5ec/nextcloud-client:$ENV
# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/nextcloud-client:$ENV
docker logout
