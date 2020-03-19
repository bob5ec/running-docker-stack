#!/bin/bash

source ../../build-system.sh

if [ "$ENV" == "prod" ]; then
	echo test would delete the prod database
	exit 1
fi

#db_volume=`docker volume ls | grep Db | cut -c 21-`
#if [ ! -z "$db_volume" ]; then
#	docker volume rm $db_volume
#fi

# test local docker-deploy
cat ../../../docker-infrastructure/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml
#get docker-deploy via git prod branch
#curl https://raw.githubusercontent.com/bob5ec/docker-infrastructure/prod/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml


function cleanup {
	set +e
	[[ "$1" == 1 ]] && echo error
	#docker exec -it app chown -R $UID.$GID /data*
	docker exec -it app rm -r /data*
	set -e
	# test local docker-deploy
	cat ../../../docker-infrastructure/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml | /bin/bash -s -- down -l ../../nextcloud.yml
	#curl https://raw.githubusercontent.com/bob5ec/docker-infrastructure/prod/roles/docker/files/docker-deploy | /bin/bash -s -- down -l ../../nextcloud.yml

#	if [ ! -z "$db_volume" ]; then
#		docker volume rm $db_volume
#	fi
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

echo TEST webdav upload and download
docker exec -it client /test || cleanup 1

#TODO echo redeploy via docker-deploy
#curl https://raw.githubusercontent.com/bob5ec/docker-infrastructure/prod/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml

#TODO echo TEST webdav upload and download
#docker exec -it client /test || cleanup 1

#DEBUG
#docker exec -it client /bin/sh


# TODO test for unauthenticated access


cleanup 0
