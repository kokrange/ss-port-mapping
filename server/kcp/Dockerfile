FROM alpine:3

ARG UID=1001
ARG GID=1001
ARG KCP_VER=20230214
ENV KCP_URL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz

ENV KEY=
ENV REMOTE_DOMAIN=
ENV REMOTE_PORT=
ENV PORT_RANGE=

RUN set -ex \
    && apk add --no-cache --update --virtual tools curl tar \
        && mkdir kcp-tmp-dir \
        && curl -sSL $KCP_URL | tar xzf - -C kcp-tmp-dir \
        && mv kcp-tmp-dir/server_linux_amd64 /usr/bin/kcpserver \
        && rm -rf kcp-tmp-dir \
    && apk del tools \
    && addgroup -g ${GID} kcps \
    && adduser -D -u ${UID} -s /bin/sh -G kcps kcps

USER kcps
WORKDIR /home/kcps/

CMD kcpserver \
             -t "$REMOTE_DOMAIN:$REMOTE_PORT" \
             -l "0.0.0.0:$PORT_RANGE" \
             --key "$KEY" \
             --crypt salsa20 \
             --mode fast3


