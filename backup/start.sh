#!/bin/bash
rm -r /root
cp -r /mnt/root /root
chmod 600 /root/.ssh/*

#[ -f /root/backup.conf ] && source /root/backup.conf
cron -f
