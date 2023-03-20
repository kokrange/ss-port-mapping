#!/bin/sh
set -ex

case "$TARGETARCH" in
   "arm") TARGET="arm6"
   ;;
   "arm/v7") TARGET="arm7"
   ;;
   "arm64") TARGET="arm64"
   ;;
   "386") TARGET="386"
   ;;
   "amd64") TARGET="amd64"
   ;;
esac

KCP_URL=https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-$TARGET-$KCP_VER.tar.gz

apk add --no-cache --update --virtual tools curl tar
mkdir kcp-tmp-dir
curl -sSL $KCP_URL | tar xzf - -C kcp-tmp-dir 
mv kcp-tmp-dir/client_linux_$TARGET /usr/bin/kcpclient 
rm -rf kcp-tmp-dir 
apk del tools 
addgroup -g ${GID} kcpc 
adduser -D -u ${UID} -s /bin/sh -G kcpc kcpc
