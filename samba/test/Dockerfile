FROM alpine
RUN apk add --no-cache samba-client
#keep the container up and wait until it is triggered from the test.sh
CMD tail -f /dev/null
