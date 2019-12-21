#!/bin/bash

COUNT=`cat /secrets/users | jq '.users|length'`
for ((i=0;i<COUNT;i++)); do
  u=`cat /secrets/users | jq ".users[$i].name" -r`
  id=`cat /secrets/users | jq ".users[$i].id" -r`
  adduser -s /sbin/nologin -h /home/$u -u $id -g users -H -D $u
  mkdir -p /home/$u
  chown $u /home/$u
  chmod 700 /home/$u
  # thank you smbpasswd for having such a crappy api
  (cat /secrets/users | jq ".users[$i].password" -r; cat /secrets/users | jq ".users[$i].password" -r) | smbpasswd -s -a $u
done

smbd --foreground --log-stdout -d 3 < /dev/null
