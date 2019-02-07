FROM stanback/alpine-samba
RUN apk add --update \
    jq \
    && rm -rf /var/cache/apk/*
COPY smb.conf /etc/samba/smb.conf
COPY bin/start.sh /usr/local/bin/start.sh
ENTRYPOINT ["sh", "/usr/local/bin/start.sh"]
