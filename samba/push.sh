#!/bin/bash
source ../build-system.sh

docker image tag bob5ec/samba:new bob5ec/samba:$ENV 
# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/samba:$ENV
docker logout
