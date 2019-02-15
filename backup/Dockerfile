FROM kurthuwig/duply
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    cron \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
COPY mirror.sh /etc/cron.daily/
COPY root/mirror.list /root/mirror.list
COPY root/mirror.excludelist /root/mirror.excludelist
ENTRYPOINT []
CMD ["cron", "-f"]
