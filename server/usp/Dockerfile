FROM alpine:3

ARG UID=1001
ARG GID=1001
ARG USP_VER=20210116.0
ENV USP_URL https://github.com/wangyu-/UDPspeeder/releases/download/$USP_VER/speederv2_binaries.tar.gz

ENV KEY=
ENV REMOTE_DOMAIN=
ENV REMOTE_PORT=
ENV PORT=29901

RUN set -ex \
    && apk add --no-cache --update bind-tools \
    && apk add --no-cache --update --virtual tools curl tar \
        && mkdir usp-tmp-dir \
        && curl -sSL $USP_URL | tar xzf - -C usp-tmp-dir \
        && mv usp-tmp-dir/speederv2_amd64 /usr/bin/usp \
        && rm -rf usp-tmp-dir \
    && apk del tools \
    && addgroup -g ${GID} usps \
    && adduser -D -u ${UID} -s /bin/sh -G usps usps

USER usps
WORKDIR /home/usps/

CMD usp -s \
        -l 0.0.0.0:$PORT \
        -r "$(dig +short $REMOTE_DOMAIN):$REMOTE_PORT" \
        -k "$KEY" \
        -f 1:3,2:4,8:6,20:10

EXPOSE $PORT/udp
