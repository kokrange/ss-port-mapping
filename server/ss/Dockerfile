FROM alpine:3

ARG UID=1001
ARG GID=1001
ARG SSR_VER=v1.11.0
ENV SS_PKG shadowsocks-$SSR_VER.x86_64-unknown-linux-musl.tar.xz
ENV SS_PKG_URL https://github.com/shadowsocks/shadowsocks-rust/releases/download/$SSR_VER/$SS_PKG
ENV SS_SUM_URL $SS_PKG_URL.sha256

ENV PASSWORD=
ENV PORT=8388

RUN set -ex \
    && apk add --no-cache --update --virtual tools curl tar xz \
        && curl -sSLO $SS_PKG_URL \
        && echo "$(curl -sSL $SS_SUM_URL)" | sha256sum -c \
        && mkdir ssr-tmp-dir \
        && tar xf $SS_PKG -C ssr-tmp-dir \
        && mv ssr-tmp-dir/ssserver /usr/bin/ \
        && rm -rf ssr-tmp-dir $SS_PKG\
    && apk del tools \
    && addgroup -g ${GID} sss \
    && adduser -D -u ${UID} -s /bin/sh -G sss sss

USER sss
WORKDIR /home/sss/

CMD ssserver \
            -U \
            -b 0.0.0.0 \
            -s 0.0.0.0:$PORT \
            -m chacha20-ietf-poly1305 \
            --timeout 60 \
            --dns google \
            --udp-timeout 180 \
            --udp-max-associations 4096 \
            -k "$PASSWORD"

EXPOSE $PORT/tcp
EXPOSE $PORT/udp
