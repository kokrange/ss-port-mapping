#!/bin/sh
set -ex


case "$TARGETARCH" in
   "apple") echo "Apple pie is quite tasty." 
   ;;
   "banana") echo "I like banana nut bread." 
   ;;
   "kiwi") echo "New Zealand is famous for kiwi." 
   ;;
esac

KCP_URL=https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-$TARGETARCH-$KCP_VER.tar.gz

apk add --no-cache --update --virtual tools curl tar
mkdir kcp-tmp-dir
curl -sSL $KCP_URL | tar xzf - -C kcp-tmp-dir 
mv kcp-tmp-dir/client_linux_$TARGETARCH /usr/bin/kcpclient 
rm -rf kcp-tmp-dir 
apk del tools 
addgroup -g ${GID} kcpc 
adduser -D -u ${UID} -s /bin/sh -G kcpc kcpc
