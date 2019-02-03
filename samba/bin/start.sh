#!/bin/sh
for u in `ls /secrets`; do
  echo adding $u
  adduser -s /sbin/nologin -h /home/$u -H -D $u
  # thank you smbpasswd for having such a crapy api
  (cat /secrets/$u; cat /secrets/$u) | smbpasswd -s -a $u
done

smbd --foreground --log-stdout
