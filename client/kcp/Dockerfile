FROM alpine:3

ARG TARGETARCH
ARG UID=1001
ARG GID=1001
ARG KCP_VER=20230214

ENV KEY=
ENV KCP_SERVER_IP=
ENV KCP_SERVER_PORT_RANGE=
ENV PORT=8388

COPY install.sh /tmp/install.sh
RUN /tmp/install.sh

USER kcpc
WORKDIR /home/kcpc/

CMD kcpclient \
             -r "$KCP_SERVER_IP:$KCP_SERVER_PORT_RANGE" \
             -l ":$PORT" \
             --key "$KEY" \
             --crypt salsa20 \
             --mode fast3 \
             --sndwnd 1024 \
             --rcvwnd 1024 \
             --conn 10 \
             --autoexpire 3600

EXPOSE $PORT/tcp
