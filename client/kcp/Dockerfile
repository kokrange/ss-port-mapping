FROM alpine:3

ARG UID=1001
ARG GID=1001
ARG KCP_VER=20210103
ENV KCP_URL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz

ENV KEY=
ENV KCP_SERVER_IP=
ENV KCP_SERVER_PORT=29900
ENV PORT=8388

RUN set -ex \
    && apk add --no-cache --update --virtual tools curl tar \
        && mkdir kcp-tmp-dir \
        && curl -sSL $KCP_URL | tar xzf - -C kcp-tmp-dir \
        && mv kcp-tmp-dir/client_linux_amd64 /usr/bin/kcpclient \
        && rm -rf kcp-tmp-dir \
    && apk del tools \
    && addgroup -g ${GID} kcpc \
    && adduser -D -u ${UID} -s /bin/sh -G kcpc kcpc

USER kcpc
WORKDIR /home/kcpc/

CMD kcpclient \
             -r "$KCP_SERVER_IP:$KCP_SERVER_PORT" \
             -l $PORT \
             --key "$KEY" \
             --crypt salsa20 \
             --mode fast3 \
             --sndwnd 1024 \
             --rcvwnd 1024 \
             --conn 10 \
             --autoexpire 3600

EXPOSE $PORT/tcp
