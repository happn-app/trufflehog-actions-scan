FROM python:3.7-alpine

RUN apk add --no-cache git less
RUN pip install gitdb2==3.0.0 truffleHog==2.1.11
COPY entrypoint.sh /entrypoint.sh
COPY regexes.json /regexes.json

ENTRYPOINT ["sh", "/entrypoint.sh"]