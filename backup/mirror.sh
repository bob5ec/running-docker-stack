#!/bin/bash
rsync -a --exclude-from '/root/mirror.excludelist' `cat /root/mirror.list` /data2/mirror
