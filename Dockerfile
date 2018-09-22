FROM python:3.6-alpine

LABEL maintainer="http://alejandro.lorente.info"

COPY rabbit_consumer_basic.py /usr/bin
COPY notify_by_telegram.py /usr/bin
COPY telegram-send.conf /etc/telegram-send.conf

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --update bash build-base openssl-dev libffi-dev && \
    pip install pika telegram-send && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* /root/.cache/*

WORKDIR /mnt

ENV QUEUE_HOST rabbit
ENV QUEUE_NAME telegram
ENV USER guest
ENV PW guest

CMD notify_by_telegram.py --host $QUEUE_HOST --user $USER --pw $PW --queue $QUEUE_NAME