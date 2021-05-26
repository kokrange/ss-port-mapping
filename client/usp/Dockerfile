FROM debian:buster-slim AS builder

ARG USP_VER=20210116.0

RUN set -ex \
    && apt update \
    && apt -y install git build-essential \
    && git clone https://github.com/wangyu-/UDPspeeder.git \
    && cd UDPspeeder \
    && git checkout $USP_VER \
    && make


FROM alpine:3

ARG UID=1001
ARG GID=1001

ENV KEY=
ENV USP_SERVER_IP=
ENV USP_SERVER_PORT=
ENV PORT=8388

COPY --from=builder /UDPspeeder/speederv2 /usr/bin/usp

RUN set -ex \
    && addgroup -g ${GID} uspc \
    && adduser -D -u ${UID} -s /bin/sh -G uspc uspc

USER uspc
WORKDIR /home/uspc/

CMD usp -c \
        -l 0.0.0.0:$PORT \
        -r "$USP_SERVER_IP:$USP_SERVER_PORT" \
        -k "$KEY" \
        -f 1:3,2:4,8:6,20:10

EXPOSE $PORT/udp
