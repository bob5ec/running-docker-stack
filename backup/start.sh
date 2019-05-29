#!/bin/bash
rm -r /root
cp -r /mnt/root /root
chmod 600 /root/.ssh/*
cron -f
