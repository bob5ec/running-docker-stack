#!/bin/bash
rsync -v -a --exclude-from '/root/mirror.excludelist' `cat /root/mirror.list` /data2/mirror >> /var/log/mirror.log
