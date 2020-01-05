#!/bin/bash
#TODO get docker-deploy via ???/git
#TODO use docker-deploy to deploy nextcloud
#TODO create emtpy test database (or overwrite the external flag in compose file)
#TODO run is alive test
#TODO rerun docker-deploy
#TODO rerun tests
function cleanup {
	[[ "$1" == 1 ]] && echo error
	docker exec -it samba chown -R $UID.$GID /data*
	docker-compose -f ../../samba.yml -f samba.override.yml -p samba-test down
	exit $1
}

#set default env to dev
export ENV=${ENV:-dev}

export UID=$UID
export GID=`id -g`
#use original compose and add client
echo "env:$ENV"
docker-compose -f ../../samba.yml -f samba.override.yml -p samba-test up -d

echo waiting for docker containers to start ...
sleep 3

echo TEST: container comes up
docker exec -it samba /bin/true || cleanup 1

echo TEST: test container comes up
docker exec -it samba-client /bin/true || cleanup 1

#docker exec -it samba-client /bin/sh || cleanup 1

echo TEST: data and user share
SHARES=`docker exec -it samba-client /bin/sh -c "echo test | smbclient -U foo -L samba -e"`
echo $SHARES
[[ $SHARES =~ "data" && $SHARES =~ "foo" ]] || cleanup 1

# TODO data share is public :-(
#echo TEST: do NOT expose data share without authentication
#docker exec -it samba-client /bin/sh -c "echo '' | smbclient -L samba | grep data" && cleanup 1

# TODO echo TEST: read and write files

#DEBUG
#docker exec -it backuptest_backup_1 /bin/bash
#docker exec -it backuptest_test-sshd_1 /bin/bash


cleanup 0