#!/bin/sh
cd /secrets
for u in ls; do
  echo adding $u
  adduser -s /sbin/nologin -h /home/samba -H -D %u
  cat /secrets/$u | smbpasswd -s -a $u
done
