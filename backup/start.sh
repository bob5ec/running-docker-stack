#!/bin/bash
rm -r /root
cp -r /mnt/root /root
chmod 600 /root/.ssh/*

[ -f /root/backup.conf ] && source /root/backup.conf
#work around for getting rid of dev an qa envirounment
tail -f /dev/null
#cron -f
