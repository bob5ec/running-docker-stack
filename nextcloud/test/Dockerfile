FROM alpine
RUN apk add --no-cache cadaver jq
COPY client/cadaver.rc /
COPY client/run /
CMD /run
#keep the container up and wait until it is triggered from the test.sh
#CMD tail -f /dev/null
