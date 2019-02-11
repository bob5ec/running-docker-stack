#!/bin/bash
#addgroup -g 100 users

COUNT=`cat /secrets/users | jq '.users|length'`
echo adding $COUNT users
for ((i=0;i<COUNT;i++)); do
  u=`cat /secrets/users | jq ".users[$i].name" -r`
  id=`cat /secrets/users | jq ".users[$i].id" -r`
  echo adding $u
  adduser -s /sbin/nologin -h /home/$u --u $id --group users -H -D $u
  mkdir -p /home/$u
  chown $u /home/$u
  chmod 700 /home/$u
  # thank you smbpasswd for having such a crappy api
  (cat /secrets/users | jq ".users[$i].password" -r; cat /secrets/users | jq ".users[$i].password" -r) | smbpasswd -s -a $u
done

smbd --foreground --log-stdout
