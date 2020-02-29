#!/bin/bash

source ../../build-system.sh

function cleanup {
	if [ "$1" == 1 ]; then
		echo error
	else
		echo done
	fi
	docker exec -it backup chown -R $UID.$GID /data*
	docker-compose -f ../../samba.yml -f samba.override.yml -p backuptest down
	exit $1
}

set +e
export UID=$UID
set -e
export GID=`id -g`
docker-compose -f ../../samba.yml -f samba.override.yml -p backuptest up -d

echo waiting for docker containers to start ...
sleep 3

echo TEST: container comes up
docker exec -it backup /bin/true || cleanup 1

echo TEST: cron is running... there is no ps available
docker exec -it backup cat /proc/*/status |grep cron || cleanup 1

echo TEST: connect to the test-sshd
docker exec backup ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no test@test-sshd -C "echo ... connection OK" || cleanup 1

# TEST case with existing last link
#docker exec test-sshd /bin/bash -c "ln -s /tmp /home/test/last" || clenup 1

# create target folder
BASE_DIR=/home/test/backup
docker exec test-sshd /bin/bash -c "mkdir -p $BASE_DIR; chown test $BASE_DIR"

echo TEST: run backup
docker exec backup /etc/cron.daily/backup.sh || cleanup 1

#echo TEST: backup exists on storage
BASE_DIR=/home/test/backup
docker exec test-sshd /bin/bash -c "[ -f $BASE_DIR/last/home/1 ] && [ ! -f $BASE_DIR/last/home/exclude1 ] && [ ! -f $BASE_DIR/last/home/exclude.a ] && [ -f $BASE_DIR/last/folder/2 ] && [ ! -f $BASE_DIR/last/folder/1.exclude ]" || cleanup 1

cleanup 0
