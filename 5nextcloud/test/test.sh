#!/bin/bash

source ../../build-system.sh

if [ "$ENV" == "prod" ] && [ -z "$TRAVIS_BRANCH" ]; then
	echo test would delete the prod database
	exit 1
fi

while IFS= read -r volume
do
	echo -n "removing volume "
	set +e
	docker volume rm "$volume"
	set -e
	echo -n "creating volume "
	docker volume create "$volume"
done < 5nextcloud/volumes


db_volume=`docker volume ls | grep Db | cut -c 21-`
if [ ! -z "$db_volume" ]; then
	docker volume rm $db_volume
fi


curl -o /tmp/docker-deploy https://raw.githubusercontent.com/bob5ec/docker-infrastructure/prod/roles/docker/files/docker-deploy
chmod +x /tmp/docker-deploy
DOCKER_DEPLOY="/tmp/docker-deploy"
cat $DOCKER_DEPLOY
ls -l $DOCKER_DEPLOY 
# test local docker-deploy
#DOCKER_DEPLOY="../../../docker-infrastructure/roles/docker/files/docker-deploy"

$DOCKER_DEPLOY -l ../..

function cleanup {
	set +e
	[[ "$1" == 1 ]] && echo error
	#docker exec -it app chown -R $UID.$GID /data*
	docker exec -it app rm -r /data*
	set -e
	$DOCKER_DEPLOY down -l ../..

	while IFS= read -r volume
	do
		echo -n "removing volume "
		set +e
		docker volume rm "$volume"
		set -e
	done < 5nextcloud/volumes
	exit $1
}
set +e
export UID=$UID
set -e
export GID=`id -g`

echo waiting for app to start ...
curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh | /bin/bash -s -- localhost:8080 -t 0

echo waiting for db to start ...
docker exec -it app /bin/bash -c "curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh | /bin/bash -s -- db:3306 -t 0"

echo wait for config run to compleate. Here is the container\'s log:
docker logs config
docker ps | grep config
error_code=$?
while [ "$error_code" == "0" ]
do
	sleep 1
	docker logs config --since 1s
	set +e
	docker ps | grep config
	error_code=$?
	set -e
done

echo TEST: config run without error
set +e
docker logs config | grep failed > /dev/null
error_code=$?
if [ "$error_code" == "0" ]; then
	cleanup 1
fi
set -e

#TODO test external storage is working
#DEBUG
docker exec -it client /bin/sh

echo TEST webdav upload and download
docker exec -it client /test || cleanup 1

echo re-deploy via docker-deploy
$DOCKER_DEPLOY -l ../..

echo waiting for app to start ...
curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh | /bin/bash -s -- localhost:8080 -t 0

echo waiting for db to start ...
docker exec -it app /bin/bash -c "curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh | /bin/bash -s -- db:3306 -t 0"

echo wait for config run to compleate. Here is the container\'s log:
docker logs config
docker ps | grep config
error_code=$?
while [ "$error_code" == "0" ]
do
	sleep 1
	docker logs config --since 1s
	set +e
	docker ps | grep config
	error_code=$?
	set -e
done

echo TEST: config run did not fail
set +e
#TODO also fail if message "command failed with exit code" is thrown on non zero exit code
docker logs config | grep failed > /dev/null
error_code=$?
if [ "$error_code" == "0" ]; then
	cleanup 1
fi
set -e

echo "TEST webdav download after redeploy (data is still avalable)"
docker exec -it client /test-redeploy || cleanup 1



# TODO test for unauthenticated access


cleanup 0
