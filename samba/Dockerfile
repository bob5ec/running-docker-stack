FROM stanback/alpine-samba
COPY smb.conf /etc/samba/smb.conf
COPY bin/start.sh /usr/local/bin/start.sh
ENTRYPOINT ["sh", "/usr/local/bin/start.sh"]
