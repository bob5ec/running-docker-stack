FROM debian:stretch
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    rsync \
    cron \
    openssh-client \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
COPY backup.sh /etc/cron.daily/backup
#COPY root/backup.list /root/backup.list
#COPY root/backup.excludelist /root/backup.excludelist

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log

#ENTRYPOINT []
#CMD cron && tail -f /var/log/cron.log
#CMD cron -f
COPY start.sh /usr/local/bin
CMD start.sh
