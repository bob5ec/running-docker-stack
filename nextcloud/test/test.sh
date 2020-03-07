#!/bin/bash

source ../../build-system.sh

# test local docker-deploy
#cat ../../../docker-infrastructure/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml
#get docker-deploy via git prod branch
curl https://raw.githubusercontent.com/bob5ec/docker-infrastructure/prod/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml

#TODO feed docker-deploy with an overwrite.yml
#TODO place test secrets in the right directory
#TODO use docker-deploy to deploy nextcloud
#TODO create emtpy test database (or overwrite the external flag in compose file)
#TODO run is alive test
#TODO rerun docker-deploy
#TODO rerun tests

function cleanup {
	[[ "$1" == 1 ]] && echo error
	#docker exec -it app chown -R $UID.$GID /data*
	docker exec -it app rm -r /data*
	# test local docker-deploy
	#cat ../../../docker-infrastructure/roles/docker/files/docker-deploy | /bin/bash -s -- -l ../../nextcloud.yml | /bin/bash -s -- down -l ../../nextcloud.yml
	curl https://raw.githubusercontent.com/bob5ec/docker-infrastructure/prod/roles/docker/files/docker-deploy | /bin/bash -s -- down -l ../../nextcloud.yml
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
	docker ps | grep config
	error_code=$?
done

echo TEST: config run without error
docker logs config | grep failed
if [ "$?" == "0" ]; then
	cleanup 1
fi
#DEBUG
#docker exec -it client /bin/sh

#TODO echo TEST: read and write files
#TODO add nextcloud-client to compose, then call it
# TODO test for unauthenticated access

#cleanup 0
####################################

#docker exec -it samba-client /bin/sh || cleanup 1

#echo TEST: data and user share
#SHARES=`docker exec -it samba-client /bin/sh -c "echo test | smbclient -U foo -L samba -e"`
#echo $SHARES
#[[ $SHARES =~ "data" && $SHARES =~ "foo" ]] || cleanup 1

cleanup 0
