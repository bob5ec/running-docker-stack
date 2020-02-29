#!/bin/bash
source ../../build-system.sh

# push the image
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push bob5ec/samba-client:$env
docker logout
