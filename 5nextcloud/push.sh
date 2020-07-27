#!/bin/bash
source ../build-system.sh

#docker image tag bob5ec/nextcloud:new bob5ec/nextcloud:$ENV
# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/nextcloud:$ENV
docker logout

cd test
./push.sh
