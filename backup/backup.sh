#!/bin/bash
 
# all backups are stored in this directory
BASISDIR=/data2/backup
#. /root/target
 
# last backup that has been performed
LAST_FULL=$BASISDIR/last
 
# location of the current to perform backup
NEW_BACKUP=$BASISDIR/`date +%F_%H-%M`

mkdir -p $NEW_BACKUP

rsync -v -a --link-dest=$LAST_FULL --exclude-from '/root/backup.excludelist' `cat /root/backup.list` $NEW_BACKUP >> /var/log/backup.log

# mark current backup as the last one
#rm $LAST_FULL
ln -s -f $NEW_BACKUP $LAST_FULL
